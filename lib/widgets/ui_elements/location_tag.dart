import 'package:flutter/material.dart';


class LocationTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: Colors.blueAccent,
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 40.0,
              color: Colors.blueAccent,
            ),
            Text(
              'Union Square, \n San Francisco',
            ),
          ],
        )
    );
  }
}
