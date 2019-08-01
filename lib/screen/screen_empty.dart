import 'package:flutter/material.dart';

class ScreenEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.black,
              size: 100.0,
            ),
            Text(
              'List is empty',
              style: TextStyle(
                fontSize: 24.0,
              ),
           ),
          ],
        )
      ),
    );
  }
}
