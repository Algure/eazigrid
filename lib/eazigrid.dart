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

  String _alignData = '';
  Map<GlobalKey, Row> usedRowKeys = {};


  late double maxWidth;
  late double maxHeight;

  EaziGrid({
    required this.children,
    this.alignment=Alignment.topLeft,
  }){
    _alignData = alignment.toString().toLowerCase();
    Row startRow = _getItemsRow(context, children);
  }

  @override
  State<EaziGrid> createState() => _EaziGridState();
}

class _EaziGridState extends State<EaziGrid> {
  List<Widget> children;
  Alignment alignment;

  String _alignData = '';
  Map<GlobalKey, Row> usedRowKeys = {};


  late double maxWidth;
  late double maxHeight;


  @override
  void initState() {
    this.children = widget.children;
    this.alignment = widget.alignment;
    _alignData = alignment.toString().toLowerCase();
    Row startRow = _getItemsRow(context, children);
  }

  @override
  Widget build(BuildContext context) {
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

  List<Widget> _getRowsConstruct(BuildContext context) {

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

  Row _getItemsRow(BuildContext context, List<Widget> tempList) {
    return  Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: _getHorizontalAlignment(),
      children: children,
    );
  }

  updateRowMap(BuildContext context){
    Map<GlobalKey, Row> usedRowKeys = this.usedRowKeys;
    List<Widget> lastChildren = [];
    for(GlobalKey globalKey in usedRowKeys.keys){
      if(lastChildren.length == 0){
        var tempList = usedRowKeys[globalKey]!.children;
        tempList.insertAll(0, lastChildren);
        if(globalKey.currentContext!.size!.width > maxWidth){
          lastChildren=[tempList.last];
          tempList.removeLast();
        }else{
          lastChildren=[];
        }
        this.usedRowKeys[globalKey] = _getItemsRow(context, tempList);
      }else{
        if (globalKey.currentContext!.size!.width > maxWidth) {
          if (usedRowKeys[globalKey]!.children.length == 1) continue;
          lastChildren.add(usedRowKeys[globalKey]!.children.last);
          var tempList = usedRowKeys[globalKey]!.children;
          tempList.removeLast();
          this.usedRowKeys[globalKey] = _getItemsRow(context, tempList);
          // Push child to next row - (1) remove last 2 children of next row child if size > maxSize
        }
      }
    }
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