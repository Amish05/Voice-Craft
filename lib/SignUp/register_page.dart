import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voice_craft/Home_Screen/home_screen.dart';
import 'package:voice_craft/Login/Login.dart';
import 'package:voice_craft/Models/Colors.dart';
import 'package:voice_craft/utils/fire_auth.dart';
import 'package:voice_craft/utils/validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showPassword = false;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  String _profilePictureUrl = '';
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

  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Upload image to Firestore Storage
        Reference storageReference = FirebaseStorage.instance.ref().child(
            'profilePictures/${_emailTextController.text}/${DateTime.now().millisecondsSinceEpoch}'); // Adding a timestamp to make the path unique

        UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get download URL
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Update the UI
        setState(() {
          _pickedImage = pickedFile;
          _profilePictureUrl = downloadURL;
        });

        // Update the Firestore document with the profile picture URL
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(_emailTextController
                .text) // Use the user's email as the document ID
            .set(
                {
              'profilePicture': downloadURL,
            },
                SetOptions(
                    merge:
                        true)); // Use merge to update the field without overwriting other fields
      }
    } catch (error) {
      print("Error picking image: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: BottomAppBar(
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(146, 46, 89, 99)
                        : Color.fromARGB(255, 0, 0, 0),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have any account ? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: Text("Log In",
                          style: GoogleFonts.anekOdia(
                              textStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0, 15, 0.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    height: 200,
                    decoration: BoxDecoration(
                      // color: Colors.black,

                      image:
                          DecorationImage(image: AssetImage('images/logo.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Color.fromARGB(146, 46, 89, 99)
                          : Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'WELCOME BACK',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameTextController,
                                  focusNode: _focusName,
                                  validator: (value) => Validator.validateName(
                                    name: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    border: myinputborder(),
                                    enabledBorder: myinputborder(),
                                    focusedBorder: myfocusborder(),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color: Colors.white),
                                    border: myinputborder(),
                                    enabledBorder: myinputborder(),
                                    focusedBorder: myfocusborder(),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText:
                                      !_showPassword, // Toggle based on the showPassword state
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.white),
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
                                    border: myinputborder(),
                                    enabledBorder: myinputborder(),
                                    focusedBorder: myfocusborder(),
                                  ),
                                ),
                                const SizedBox(height: 32.0),
                                Row(
                                  children: [
                                    OutlinedButton(
                                        onPressed: _pickImage,
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          elevation: 15.0,
                                          fixedSize: const Size.fromHeight(45),
                                        ),
                                        child: Text('Select Image',
                                            style: GoogleFonts.anekOdia(
                                                textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : MyColors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                    if (_pickedImage != null)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.file(
                                            File(_pickedImage!.path),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size.fromHeight(45),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          elevation: 15.0,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          if (_registerFormKey.currentState!
                                              .validate()) {
                                            try {
                                              User? user = await FireAuth
                                                  .registerUsingEmailPassword(
                                                name: _nameTextController.text,
                                                email:
                                                    _emailTextController.text,
                                                password:
                                                    _passwordTextController
                                                        .text,
                                              );

                                              if (user != null) {
                                                // Save user data to Firestore
                                                await FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(_emailTextController
                                                        .text)
                                                    .set({
                                                  'Name':
                                                      _nameTextController.text,
                                                  'Email':
                                                      _emailTextController.text,
                                                  'ProfilePicture':
                                                      _profilePictureUrl,
                                                });

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ),
                                                );
                                              }
                                            } on FirebaseAuthException catch (e) {
                                              String errorMessage;

                                              if (e.code ==
                                                  'email-already-in-use') {
                                                errorMessage =
                                                    'The account already exists for that email.';
                                                 ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(errorMessage),
                                                ),
                                              );
                                              } else {
                                                errorMessage =
                                                    'An error occurred. Please try again.';
                                              }

                                              setState(() {
                                                _isProcessing = false;
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(errorMessage),
                                                ),
                                              );
                                            } catch (error) {
                                              print(
                                                  'Error saving user data: $error');
                                            }
                                          } else {
                                            setState(() {
                                              _isProcessing = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 86, 78),
                                            fontWeight: FontWeight.w800,
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
        color: Color.fromARGB(171, 69, 139, 162),
        width: 2,
      ));
}
