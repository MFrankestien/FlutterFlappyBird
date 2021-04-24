import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  const MyBarrier(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 100,

    );
  }
}
