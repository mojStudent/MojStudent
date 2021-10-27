import 'package:flutter/material.dart';

class NotSupported extends StatelessWidget {
  const NotSupported({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.browser_not_supported,
            size: 68,
            color: Colors.black26,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Storitev trenutno še ni podprta",
            style: TextStyle(fontSize: 20, color: Colors.black26),
          ),
        ],
      ),
    );
  }
}
