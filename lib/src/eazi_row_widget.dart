import 'package:flutter/material.dart';

/// Row component widgets seperated to assign individual BuildContexts to GlobalKeys used in
/// [EaziGrid]'s [updateRowMapForSmallerScreens] method
class EaziRowWidget extends StatefulWidget {
  const EaziRowWidget(
      {Key? key, required this.mainAxisAlignment, required this.children})
      : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<EaziRowWidget> createState() => _EaziRowWidgetState();
}

class _EaziRowWidgetState extends State<EaziRowWidget> {
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
