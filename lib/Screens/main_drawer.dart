import 'package:all_paws/Screens/welcome_screen.dart';
import 'package:all_paws/controllers/authentication.dart';
import "package:flutter/material.dart";

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => signOutUser().then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
