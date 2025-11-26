import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:voice_craft/emotion/ui/camera.dart';
import 'package:voice_craft/emotion/ui/gallery.dart';
import 'package:voice_craft/essentials/button.dart';

class emotionpage extends StatefulWidget {
  const emotionpage({Key? key}) : super(key: key);

  @override
  State<emotionpage> createState() => _emotionpageState();
}

class _emotionpageState extends State<emotionpage> {
  late CameraDescription cameraDescription;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPages();
    });
  }

  initPages() async {
    if (cameraIsAvailable) {
      cameraDescription = (await availableCameras()).first;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 33, 48),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Voice Craft',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 69, 216, 246),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenwidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 69, 216, 246),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(08, 18, 08, 0),
                    child: Text(
                      "Voice Craft",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(08, 0, 08, 25),
                    child: Text(
                      "The Audio Generator",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'kaushan',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Button to import image from gallery
            myButton(
              buttontext: 'Import',
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryScreenEmotion(),
                  ),
                );
              },
            ),
            myButton(buttontext: 'Recents', onpressed: () {}),
            myButton(
              buttontext: 'Live',
              onpressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CameraScreenEmotion(camera: cameraDescription),
                  ),
                );
              },
            ),
            myButton(buttontext: 'Clear Data', onpressed: () {}),
          ],
        ),
      ),
    );
  }
}
