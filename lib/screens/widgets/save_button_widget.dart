import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function onClick;
  final IconData icon;
  final String text;

  const SaveButton(
      {Key? key,
      required this.onClick,
      this.icon = Icons.save,
      this.text = "Shrani"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 35)),
        onPressed: () => onClick());
  }
}
