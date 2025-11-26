import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:voice_craft/Sound_ide/Sound_live.dart';
import 'package:voice_craft/emotion/ui/gallery.dart';
import 'package:voice_craft/essentials/button.dart';
import 'package:permission_handler/permission_handler.dart';

class Sound_ide_page extends StatefulWidget {
  const Sound_ide_page({Key? key}) : super(key: key);

  @override
  State<Sound_ide_page> createState() => _Sound_ide_pageState();
}

class _Sound_ide_pageState extends State<Sound_ide_page> {
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
            // Button to start live Sound recognition
            myButton(
              buttontext: 'Live',
              onpressed: () async {
                var status = await Permission.microphone.request();
                if (status.isGranted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Sound_live(),
                    ),
                  );
                } else {
                  // Handle case where microphone permission is not granted
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Permission Required'),
                      content: Text(
                          'Microphone permission is required for live Sound recognition.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            myButton(buttontext: 'Clear Data', onpressed: () {}),
          ],
        ),
      ),
    );
  }
}
