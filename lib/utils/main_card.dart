import 'package:all_paws/Screens/animal.dart';
import 'package:all_paws/Screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCard extends StatelessWidget {
  Animal animal;
  MainCard(this.animal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DetailScreen(animal))),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                //background color of box
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 0.5, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text("${animal.name}",
                          style: GoogleFonts.redressed(
                              fontSize: 30,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[900])),
                    ]),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${animal.location}",
                      style: TextStyle(fontSize: 12, letterSpacing: 2),
                    ),
                    Text(
                      "${animal.ageNumber} Years Old",
                      style: TextStyle(fontSize: 15, letterSpacing: 2),
                    )
                  ]),
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage("${animal.photos[0]}"), fit: BoxFit.fill),
              ),
            ),
          )
        ],
      ),
    );
  }
}
