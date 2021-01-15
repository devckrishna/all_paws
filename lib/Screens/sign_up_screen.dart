import 'package:all_paws/Screens/home_screen.dart';
import 'package:all_paws/controllers/authentication.dart';
import "package:flutter/material.dart";

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool isLoading = false;
  bool showLoading = false;

  signInUser(BuildContext context) {
    try {
      googleSignIn().then((value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())));
    } catch (err) {
      print("Something went wrong");
    }
  }

  registerUser() async {
    _formKey.currentState.save();
    print(_email);
    print(_password);
    try {
      setState(() {
        isLoading = true;
        showLoading = true;
      });
      bool isSignedUp = await signUp(_email, _password);
      if (isSignedUp) {
        bool isSignedIn = await signIn(_email, _password);
        if (isSignedIn) {
          setState(() {
            isLoading = false;
            showLoading = false;
          });
          return Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    } catch (e) {
      print("something went wrong");
    }
    setState(() {
      isLoading = false;
      showLoading = false;
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
      child: showLoading
          ? showLoader()
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                          onPressed: () => Navigator.of(context).pop())
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Image(
                      image: AssetImage("images/welcome/signup.png"),
                    )),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter Details to Sign-Up",
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          onSaved: (text) => this._email = text,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          onSaved: (text) => this._password = text,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          controller: _passwordConfirmController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => registerUser(),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
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
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Or Sign-In With",
                  style: TextStyle(letterSpacing: 2),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () => signInUser(context),
                  child: Image(
                    image: AssetImage("images/welcome/google.png"),
                    height: 35,
                  ),
                )
              ],
            ),
    ));
  }
}
