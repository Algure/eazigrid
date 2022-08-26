import 'package:flutter/material.dart';

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
