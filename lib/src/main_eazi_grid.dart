
import 'dart:collection';

import 'package:eazigrid/src/eazi_row_widget.dart';
import 'package:eazigrid/src/utilities.dart';
import 'package:flutter/material.dart';

///
class EaziGrid extends StatefulWidget {
  bool isScrollable;

  /// horizontalAlignment aligns children in each row to any of the options in [EaziAlignment]
  EaziAlignment horizontalAlignment;
  EaziAlignment verticalAlignment;
  List<Widget> children;

  EaziGrid({
    required this.children,
    this.horizontalAlignment = EaziAlignment.start,
    this.verticalAlignment = EaziAlignment.start,
    this.isScrollable = false
  }){
  }

  @override
  State<EaziGrid> createState() => _EaziGridState();
}


class _EaziGridState extends State<EaziGrid> {
  double maxWidth = 0;
  double maxHeight = 0;
  LinkedHashMap<dynamic, RowWidget> usedRowKeys = LinkedHashMap<dynamic, RowWidget>();

  @override
  void initState() {
    addItemsRow(context, widget.children);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateRowMapForSmallerScreens(context);
    });
    return LayoutBuilder(
        builder: (context, constraints){
          if(maxWidth<constraints.maxWidth){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              drawBackWidgetFromBottomRow(context);
            });
          }
          maxWidth = constraints.maxWidth;
          maxHeight = constraints.maxWidth;

          if(widget.isScrollable){
            return SingleChildScrollView(
              child: _getMainWidget(),
            );
          }else {
            return _getMainWidget();
          }
        }
    );
  }

  Widget _getMainWidget() => Container(
    child: Column(
      mainAxisAlignment: _getAlignmentFromEaziAlignment(widget.verticalAlignment),
      crossAxisAlignment: _getCrossAxisAlignmentFromEaziAlignment(widget.horizontalAlignment),
      children: [
        for(GlobalKey key in usedRowKeys.keys)
          usedRowKeys[key]!,
      ],
    ),
  );

  MainAxisAlignment _getAlignmentFromEaziAlignment(EaziAlignment eaziAlignment) {
    if(eaziAlignment == EaziAlignment.start) {
      return MainAxisAlignment.start;
    }else if(eaziAlignment == EaziAlignment.center){
      return MainAxisAlignment.center;
    }else {
      return MainAxisAlignment.end;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignmentFromEaziAlignment(EaziAlignment eaziAlignment) {
    if(eaziAlignment == EaziAlignment.start) {
      return CrossAxisAlignment.start;
    }else if(eaziAlignment == EaziAlignment.center){
      return CrossAxisAlignment.center;
    }else {
      return CrossAxisAlignment.end;
    }
  }

  void addItemsRow(BuildContext context, List<Widget> tempList, [GlobalKey? globalKey]) {
    final row = RowWidget(
      key: globalKey??GlobalKey(),
      mainAxisAlignment: _getAlignmentFromEaziAlignment(widget.horizontalAlignment),
      children: tempList,
    );
    usedRowKeys[row.key] = row;
  }

  updateRowMapForSmallerScreens(BuildContext context){
    bool madeChange = false;
    final usedRowKeys = this.usedRowKeys;
    List<Widget> lastChildren = [];
    double k=0;
    for(GlobalKey globalKey in usedRowKeys.keys){
      MediaQuery.of(context).size.width; /// This weird line must be present 🤨
      if(lastChildren.length > 0){
        var tempList = usedRowKeys[globalKey]!.children;
        tempList.insertAll(0, lastChildren);
        if(globalKey.currentContext!.size!.width >= maxWidth){
          lastChildren=[tempList.removeLast()];
        }else{
          lastChildren.clear();
        }
        addItemsRow(context, tempList, globalKey);
      }else{
        if (globalKey.currentContext!.size!.width >= maxWidth) {
          if (usedRowKeys[globalKey]!.children.length == 1) continue;
          var tempList = usedRowKeys[globalKey]!.children;
          lastChildren.add(tempList.removeLast());
          addItemsRow(context, tempList, globalKey);
          // Push child to next row - (1) remove last 2 children of next row child if size > maxSize
          madeChange = true;
        }
      }
    }
    if(lastChildren.length > 0){
      addItemsRow(context, lastChildren);
    }
    if(madeChange){
      rebuild();
    }
  }

  drawBackWidgetFromBottomRow(BuildContext context){
    usedRowKeys.clear();
    addItemsRow(context, widget.children.toList());
    rebuild();
  }

  void rebuild() {
    if(mounted) setState(() {});
  }

}