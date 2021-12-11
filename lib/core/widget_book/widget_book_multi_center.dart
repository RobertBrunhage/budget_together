import 'package:flutter/material.dart';

class WidgetBookCenter extends StatelessWidget {
  const WidgetBookCenter({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children
            .map(
              (child) => Padding(
                padding: const EdgeInsets.all(8),
                child: child,
              ),
            )
            .toList(),
      ),
    );
  }
}
