import 'package:all_paws/Screens/animal.dart';
import 'package:all_paws/utils/main_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adoptions extends StatefulWidget {
  @override
  _AdoptionsState createState() => _AdoptionsState();
}

class _AdoptionsState extends State<Adoptions> {
  @override
  List<Animal> _animals = [];
  User user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      DocumentSnapshot arr = value;

      List<String> favs =
          arr["adoptions"] == null ? [] : List<String>.from(arr["adoptions"]);
      if (favs.length != 0) {
        for (int i = 0; i < favs.length; i++) {
          int curr =
              allAnimals.indexWhere((item) => item.id == favs[i].toString());
          // print(curr);
          setState(() {
            _animals.add(allAnimals[curr]);
          });
        }
      }

      print(_animals.length);
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget showLoader() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? showLoader()
            : Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Your Adoptions",
                    style: GoogleFonts.robotoMono(
                        fontSize: 25,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _animals.length == 0
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "You Don't Have Any Adoptions...",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(
                              fontSize: 20, letterSpacing: 2),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: _animals.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: MainCard(_animals[index]));
                            }),
                      )
              ]),
      ),
    );
  }
}
