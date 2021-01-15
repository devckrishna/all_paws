import 'package:flutter/material.dart';

import 'animal.dart';

class DetailScreen extends StatefulWidget {
  Animal animal;
  DetailScreen(this.animal);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.animal.photos[0]),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
