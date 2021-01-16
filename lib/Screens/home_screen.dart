import 'dart:ui';
import 'package:all_paws/Screens/main_drawer.dart';

import './animal.dart';
import 'package:all_paws/Screens/welcome_screen.dart';
import 'package:all_paws/controllers/authentication.dart';
import 'package:all_paws/utils/main_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Animal> _category = dogs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding:
                  EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/account.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.bars,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer())
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                itemCount: _category.length,
                itemBuilder: (context, index) {
                  return index == 0
                      ? Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        color: Colors.black38),
                                  ),
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: Colors.red[700],
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "New Delhi, Delhi",
                                      style: TextStyle(
                                          fontSize: 30,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepPurple),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: EdgeInsets.only(left: 10, top: 30),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: FaIcon(FontAwesomeIcons.slidersH),
                                      onPressed: () {}),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _category = dogs;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      padding: EdgeInsets.all(8),
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "Dogs",
                                        style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.black87),
                                      )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _category = cats;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      padding: EdgeInsets.all(8),
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "Cats",
                                        style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.black87),
                                      )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _category = bunnies;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      padding: EdgeInsets.all(8),
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "Rabbits",
                                        style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.black87),
                                      )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _category = birds;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      padding: EdgeInsets.all(8),
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "Birds",
                                        style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.black87),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30)
                        ])
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MainCard(_category[index]));
                },
              ),
            ),
          ]),
        ));
  }
}
