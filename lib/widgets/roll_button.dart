import 'dart:math';

import 'package:flutter/material.dart';

int roll(int itemCount) {
  return Random().nextInt(itemCount);
}

typedef IntCallback = void Function(int);

class RollButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RollButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Escolhe pra mim'),
      onPressed: onPressed,
    );
  }
}

class RollButtonWithPreview extends StatelessWidget {
  final int selected;
  final List<String> items;
  final VoidCallback? onPressed;

  const RollButtonWithPreview({
    Key? key,
    required this.selected,
    required this.items,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        RollButton(onPressed: onPressed)
      ],
    );
  }
}