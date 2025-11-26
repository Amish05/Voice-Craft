import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_craft/Home_Screen/home_screen.dart';
import 'package:voice_craft/Models/Colors.dart';
import 'package:voice_craft/Profile/ProfileScreen.dart';
// import 'package:r2dae/Drivers/Drivers.dart';
// import 'package:r2dae/Drivers_login/DriverHomeScreen.dart';
// import 'package:voice_craft/Profile/profile_page.dart';
import 'package:voice_craft/SignUp/register_page.dart';
// import 'package:r2dae/admin1/admin_Drivers.dart';
import 'package:voice_craft/utils/fire_auth.dart';
import 'package:voice_craft/utils/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showPassword = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
                // user: user,
                ),
          ),
        );
      }
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      
      bottomNavigationBar: ClipRRect(
     
                           
                          
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: BottomAppBar(
              child: Container(
                  decoration: BoxDecoration(
                     color: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(146, 46, 89, 99)
          :Color.fromARGB(255, 0, 0, 0),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have any account ? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  RegisterPage(),
                              ));
                        },
                        child:  Text("Sign up",
                            style: GoogleFonts.anekOdia(
                textStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : MyColors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
                      )
                    ],
                  )),
            ),
          ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   margin: EdgeInsets.only(top: height / 6, bottom: 20),
              //   height: 150,
              //   width: 150,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('images/logo.png'),
              //     ),
              //   ),
              // ),

              // Container(
              //   width: screenWidth,
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     image: DecorationImage(image: AssetImage('images/logo.png')),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 30, 15, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      height: 150,
                      width: 150,
                      child: Stack(
                        children: [
                          // RotationTransition(
                          //   turns: _controller,
                          //   child: Container(
                          //     decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //           image: AssetImage('images/Group.png')),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 200,
                            width: 230,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/logo.png')),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(146, 46, 89, 99)
          :Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,)
,                            Text(
                              'WELCOME BACK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: _emailTextController,
                                      focusNode: _focusEmail,
                                      validator: (value) =>
                                          Validator.validateEmail(
                                        email: value,
                                      ),
                                      decoration: InputDecoration(
                                        // hintText: "Email",
                                        labelText: "Email",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        ),
                                        border: myinputborder(),
                                        enabledBorder: myinputborder(),
                                        focusedBorder: myfocusborder(),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: _passwordTextController,
                                      focusNode: _focusPassword,
                                      style: TextStyle(color: Colors.white),
                                      obscureText:
                                          !_showPassword, // Toggle based on the showPassword state
                                      validator: (value) =>
                                          Validator.validatePassword(
                                        password: value,
                                      ),

                                      decoration: InputDecoration(
                                        // hintText: "Password",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _showPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _showPassword = !_showPassword;
                                            });
                                          },
                                        ),
                                        enabledBorder: myinputborder(),
                                        border: myinputborder(),
                                        focusedBorder: myfocusborder(),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    // const SizedBox(height: 24.0),
                                    _isProcessing
                                        ? const CircularProgressIndicator()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    fixedSize:
                                                        const Size.fromHeight(
                                                            45),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    elevation: 15.0,
                                                  ),
                                                  onPressed: () async {
                                                    _focusEmail.unfocus();
                                                    _focusPassword.unfocus();

                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      var pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      pref.setBool(
                                                          "Login", true);
                                                      setState(() {
                                                        _isProcessing = true;
                                                      });

                                                      // Sign in using email and password
                                                      User? user = await FireAuth
                                                          .signInUsingEmailPassword(
                                                        email:
                                                            _emailTextController
                                                                .text,
                                                        password:
                                                            _passwordTextController
                                                                .text,
                                                      );

                                                      setState(() {
                                                        _isProcessing = false;
                                                      });
                                                      if (user != null) {
                                                        // Successful sign-in
                                                        if (user.email ==
                                                            "admin@gmail.com") {
                                                          // Navigator.of(context).pushReplacement(
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) => BookedCars(),
                                                          //   ),
                                                          // );
                                                        } else {
                                                          // Successful sign-in
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Home_Screen(),
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        // Failed sign-in
                                                        // ignore: use_build_context_synchronously
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Error'),
                                                              content: const Text(
                                                                  'Invalid email or password. Please try again.'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Sign In',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 86, 78),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                   
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //}
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ));
}
