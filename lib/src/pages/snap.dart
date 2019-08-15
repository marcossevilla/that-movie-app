import 'package:flutter/material.dart';
import 'package:snappable/snappable.dart';

class Snap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Snappable(
        snapOnTap: true,
        child: Image(image:AssetImage('assets/img/thanos.jpg')),
      ),
    );
  }
}