import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class BackNavigationButton extends StatelessWidget {
  const BackNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        FlutterRemix.arrow_left_s_line,
        color: Colors.white,
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
