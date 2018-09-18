import 'package:flutter/material.dart';

class NativeListItem extends StatelessWidget {
  NativeListItem({@required this.index});

  final int index;

  static const colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors[index % colors.length],
    );
  }
}
