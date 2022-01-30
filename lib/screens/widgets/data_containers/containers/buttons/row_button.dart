import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function onPressed;

  const RowButton(
      {Key? key, this.icon, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.0075, horizontal: w * 0.06),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              ),
            if (icon != null)
              SizedBox(
                width: 20,
              ),
            Text(title,
                style: TextStyle(
                  color: Colors.white,
                )),
          ]),
        ),
      ),
    );
  }
}
