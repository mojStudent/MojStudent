import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool withScaffold;
  final bool expanded;
  final Color? background;

  const LoadingScreen(
      {Key? key,
      this.withScaffold = true,
      this.expanded = false,
      this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: _buildExpandedProp(context),
          )
        : _buildExpandedProp(context);
  }

  Widget _buildExpandedProp(BuildContext context) {
    return expanded ? Expanded(child: _body(context)) : _body(context);
  }

  Center _body(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background ?? Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Nalaganje, prosim počakajte",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
