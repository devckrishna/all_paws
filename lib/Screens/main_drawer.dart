import 'package:all_paws/Screens/about_screen.dart';
import 'package:all_paws/Screens/adoptions.dart';
import 'package:all_paws/Screens/favorites_screen.dart';
import 'package:all_paws/Screens/welcome_screen.dart';
import 'package:all_paws/controllers/authentication.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 100, left: 20),
        color: Colors.deepPurple[400],
        child: Column(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.home, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 21, color: Colors.white, letterSpacing: 3),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Adoptions()),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.paw, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Adoptions",
                    style: TextStyle(
                        fontSize: 21, color: Colors.white, letterSpacing: 3),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.solidHeart, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Favorites",
                    style: TextStyle(
                        fontSize: 21, color: Colors.white, letterSpacing: 3),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AboutScreen()),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.bookOpen, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                        fontSize: 21, color: Colors.white, letterSpacing: 3),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                signOutUser();
                return Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(
                        fontSize: 21, color: Colors.white, letterSpacing: 3),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
