library eazigrid;

import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}


class EaziGrid extends StatelessWidget {
  List<Widget> children;
  Alignment alignment;
  double maxItemWidth;
  double minItemWidth;
  double? maxItemHeight;
  double? minItemHeight;
  double? padding;
  double width;

  String _alignData = '';
  double _workingWidth = 0;



  EaziGrid({required this.children,
    required this.width,
    this.alignment=Alignment.topLeft,
    this.maxItemHeight,
    this.minItemHeight,
    required this.maxItemWidth,
    required this.minItemWidth,
    this.padding
  }){

    _alignData = alignment.toString().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: _getVerticalAlignment(),
        children: [
          for(Widget child in _getRowsConstruct(context))
            child,
        ],
      ),
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
    double screenWidth = width == double.maxFinite?MediaQuery.of(context).size.width:width;
    List<Widget> result = [];
    List<Widget> tempList = [];
    double totalWidth = 0;
    for(Widget child in children){
      totalWidth += minItemWidth;
      if(totalWidth >= screenWidth){
        result.add(_getItemsRow(context, tempList));
        tempList = [child];
        totalWidth = minItemWidth;
      }else{
        tempList.add(Expanded(child: child));
      }
    }
    result.add(_getItemsRow(context, tempList));
    return result;
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

  Widget _getItemsRow(BuildContext context, List<Widget> tempList) {
    return Container(
       height: maxItemHeight,
      child: Row(
        mainAxisAlignment: _getHorizontalAlignment(),
        children: children,
      ),
    );
  }
}

