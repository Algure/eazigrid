library eazigrid;

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class EaziGrid extends StatefulWidget {
  List<Widget> children;
  Alignment alignment;

  EaziGrid({
    required this.children,
    this.alignment=Alignment.topLeft,
  }){
  }

  @override
  State<EaziGrid> createState() => _EaziGridState();
}

class _EaziGridState extends State<EaziGrid> {
  String _alignData = '';
  late Alignment alignment;
  double maxWidth = 0;
  double maxHeight = 0;

  LinkedHashMap<dynamic, RowWidget> usedRowKeys = LinkedHashMap<dynamic, RowWidget>();


  @override
  void initState() {
    this.alignment = widget.alignment;
    _alignData = alignment.toString().toLowerCase();
    RowWidget startRow = _getItemsRow(context, widget.children.toList());
    usedRowKeys[startRow.key] = startRow;
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
              maxWidth = constraints.maxWidth;
              maxHeight = constraints.maxWidth;
              drawBackWidgetFromBottomRow(context);
            });
          }
          maxWidth = constraints.maxWidth;
          maxHeight = constraints.maxWidth;
          return Container(
            child: Column(
              mainAxisAlignment: _getVerticalAlignment(),
              children: [
                for(GlobalKey key in usedRowKeys.keys)
                  usedRowKeys[key]!,
              ],
            ),
          );
        }
    );
  }


  MainAxisAlignment _getVerticalAlignment() {
    if(_alignData.contains('top')){
      return MainAxisAlignment.start;
    }else if(_alignData.contains('center')){
      return MainAxisAlignment.center;
    }else {
      return MainAxisAlignment.end;
    }
  }

  MainAxisAlignment _getHorizontalAlignment() {
    if(_alignData.contains('left')){
      return MainAxisAlignment.start;
    }else if(_alignData.contains('center')){
      return MainAxisAlignment.center;
    }else {
      return MainAxisAlignment.end;
    }
  }

  RowWidget _getItemsRow(BuildContext context, List<Widget> tempList, [GlobalKey? globalKey]) {
    return RowWidget(
      // mainAxisSize: MainAxisSize.min,
      key: globalKey??GlobalKey(),
      mainAxisAlignment: _getHorizontalAlignment(),
      children: tempList,
    );
  }

  updateRowMapForSmallerScreens(BuildContext context){
    LinkedHashMap<dynamic, RowWidget> usedRowKeys = this.usedRowKeys;
    List<Widget> addToStartChildren = [];
    bool madeChange = false;
    // print('ran');
    for(GlobalKey globalKey in usedRowKeys.keys){
      // print('globalKey.currentContext!.size!.width: ${globalKey.currentContext!.size!.width}, maxWidth: ${MediaQuery.of(context).size.width}');
      if(addToStartChildren.length > 0){
        var tempList = usedRowKeys[globalKey]!.children;
        tempList.insertAll(0, addToStartChildren);
        if(globalKey.currentContext!.size!.width >= maxWidth){
          addToStartChildren=[tempList.removeLast()];
        }else{
          addToStartChildren=[];
        }
        this.usedRowKeys[globalKey] = _getItemsRow(context, tempList, globalKey);
      }else{
        if (globalKey.currentContext!.size!.width >= maxWidth) {
          if (usedRowKeys[globalKey]!.children.length == 1) continue;
          var tempList = usedRowKeys[globalKey]!.children;
          addToStartChildren.add(tempList.removeLast());
          this.usedRowKeys[globalKey] = _getItemsRow(context, tempList, globalKey);
          // Push child to next row - (1) remove last 2 children of next row child if size > maxSize
          madeChange = true;
        }
      }
    }
    if(addToStartChildren.length > 0){
      RowWidget startRow = _getItemsRow(context, addToStartChildren);
      this.usedRowKeys[startRow.key] = startRow;
    }
    if(madeChange){
      print('is to make change');
      setState(() {

      });
    }
  }

  drawBackWidgetFromBottomRow(BuildContext context){
    usedRowKeys =  LinkedHashMap<dynamic, RowWidget>();
    RowWidget startRow = _getItemsRow(context, widget.children.toList());
    usedRowKeys[startRow.key] = startRow;
      setState(() {

      });
  }

}

//TODO: Create custom row with context.
class RowWidget extends StatefulWidget {
  const RowWidget({Key? key, required this.mainAxisAlignment, required this.children, }) : super(key: key);

  final  List<Widget> children;
  final  MainAxisAlignment mainAxisAlignment;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: widget.children,
      ),
    );
  }
}

String genRandomString(int length) {
  String data= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  String result = '';
  for(int i =0 ; i< length; i++){
    result += data[Random().nextInt(data.length)];
  }
  return result;
}