library eazigrid;

import 'dart:async';
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
  late List<Widget> children;
  late double maxWidth;
  late double maxHeight;

  Map<dynamic, Row> usedRowKeys = {};


  @override
  void initState() {
    this.children = widget.children;
    this.alignment = widget.alignment;
    _alignData = alignment.toString().toLowerCase();
    Row startRow = _getItemsRow(context, children);
    usedRowKeys[startRow.key] = startRow;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateRowMap(context);
    });
    return LayoutBuilder(
        builder: (context, constraints){
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

  Row _getItemsRow(BuildContext context, List<Widget> tempList, [GlobalKey? globalKey]) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      key: globalKey??GlobalKey(),
      mainAxisAlignment: _getHorizontalAlignment(),
      children: children,
    );
  }

  updateRowMap(BuildContext context){
    Map<dynamic, Row> usedRowKeys = this.usedRowKeys;
    List<Widget> lastChildren = [];
    bool madeChange = false;
    print('ran');
    for(GlobalKey globalKey in usedRowKeys.keys){
      print('globalKey.currentContext!.size!.width: ${globalKey.currentContext!.size!.width}, maxWidth: $maxWidth');
      if(lastChildren.length == 0){
        var tempList = usedRowKeys[globalKey]!.children;
        tempList.insertAll(0, lastChildren);
        if(globalKey.currentContext!.size!.width >= maxWidth){
          lastChildren=[tempList.last];
          tempList.removeLast();
        }else{
          lastChildren=[];
        }
        this.usedRowKeys[globalKey] = _getItemsRow(context, tempList, globalKey);
      }else{
        if (globalKey.currentContext!.size!.width >= maxWidth) {
          if (usedRowKeys[globalKey]!.children.length == 1) continue;
          lastChildren.add(usedRowKeys[globalKey]!.children.last);
          var tempList = usedRowKeys[globalKey]!.children;
          tempList.removeLast();
          this.usedRowKeys[globalKey] = _getItemsRow(context, tempList, globalKey);
          // Push child to next row - (1) remove last 2 children of next row child if size > maxSize
          madeChange = true;
        }
      }
    }
    if(lastChildren.length > 0){
      Row startRow = _getItemsRow(context, lastChildren);
      usedRowKeys[startRow.key] = startRow;
    }
    if(madeChange){
      setState(() {

      });
    }
  }

}

//TODO: Create custom row with context.

String genRandomString(int length) {
  String data= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  String result = '';
  for(int i =0 ; i< length; i++){
    result += data[Random().nextInt(data.length)];
  }
  return result;
}