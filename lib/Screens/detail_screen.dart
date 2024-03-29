import 'package:all_paws/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'animal.dart';

class DetailScreen extends StatefulWidget {
  Animal animal;
  DetailScreen(this.animal);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFav = false;
  bool _isAdopted = false;
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      DocumentSnapshot arr = value;
      if (arr["favorites"].contains(widget.animal.id)) {
        setState(() {
          _isFav = true;
        });
      }
      if (arr["adoptions"].contains(widget.animal.id)) {
        setState(() {
          _isAdopted = true;
        });
      }
    });
  }

  User user = FirebaseAuth.instance.currentUser;

  addToAdoptions() async {
    List<dynamic> val = [widget.animal.id];

    DocumentSnapshot arr = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    print(arr["adoptions"]);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"adoptions": FieldValue.arrayUnion(val)});
  }

  removeFromAdoptions() async {
    List<dynamic> val = [widget.animal.id];

    DocumentSnapshot arr = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    print(arr["adoptions"]);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"adoptions": FieldValue.arrayRemove(val)});
  }

  addToFavorites() async {
    List<dynamic> val = [widget.animal.id];

    DocumentSnapshot arr = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    print(arr["favorites"]);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"favorites": FieldValue.arrayUnion(val)});
  }

  removeFromFavorites() async {
    List<dynamic> val = [widget.animal.id];

    DocumentSnapshot arr = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    print(arr["favorites"]);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"favorites": FieldValue.arrayRemove(val)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 380,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      image: DecorationImage(
                          image: AssetImage(widget.animal.photos[0]),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: Colors.red[700],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.animal.location}",
                    style: TextStyle(fontSize: 18, letterSpacing: 2),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.paw,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 120,
                          child: Text(
                            "${widget.animal.breed}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, letterSpacing: 2),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.genderless,
                          color: Colors.pink[300],
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 70,
                          child: Text(
                            "${widget.animal.gender}",
                            style: TextStyle(fontSize: 17, letterSpacing: 2),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Age: ${widget.animal.ageNumber} Years Old",
              style: TextStyle(fontSize: 18, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              "Weight: ${widget.animal.weightNumber} Kgs",
              style: TextStyle(fontSize: 18, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              "Owner: ${widget.animal.ownerName} ",
              style: TextStyle(fontSize: 18, letterSpacing: 2),
            ),
            SizedBox(height: 20),
            Text(
              "About",
              style: TextStyle(
                  fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${widget.animal.ownerStatement}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 2,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isAdopted = !_isAdopted;
                      });
                      if (_isAdopted) {
                        addToAdoptions();
                        showDialog(
                            context: context,
                            builder: (_) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                title: Text('Status'),
                                content: Text('Adoption Request Sent'),
                              );
                            });
                      }
                      if (!_isAdopted) {
                        removeFromAdoptions();
                        showDialog(
                            context: context,
                            builder: (_) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                title: Text('Status'),
                                content: Text('Adoption Request Withdrawn'),
                              );
                            });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple,
                        boxShadow: [
                          //background color of box
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 0.2, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Text(
                        "Adopt Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isFav = !_isFav;
                      });
                      if (_isFav) {
                        addToFavorites();
                      }
                      if (!_isFav) {
                        removeFromFavorites();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pinkAccent[100],
                        boxShadow: [
                          //background color of box
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 0.2, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: FaIcon(
                        _isFav
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
