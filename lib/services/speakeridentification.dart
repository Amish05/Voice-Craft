import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:voice_craft/essentials/CameraPage.dart';
import 'package:voice_craft/essentials/button.dart';

class Soundidentification extends StatefulWidget {
  const Soundidentification({Key? key}) : super(key: key);

  @override
  _SoundidentificationState createState() => _SoundidentificationState();
}

class _SoundidentificationState extends State<Soundidentification> {
  Future<void> _pickVoiceFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        String filePath = result.files.first.path!;

        // Do something with the picked voice file (e.g., process or play)
        print("Voice picked from gallery: $filePath");
      }
    } catch (e) {
      print("Error picking voice: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // downloadModel('Sound_identification');
    print("super is called");
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
 backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,      appBar: AppBar(
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
              width: screenWidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 69, 216, 246),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 18, 8, 0),
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
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 25),
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
            myButton(
              buttontext: 'Import Voice',
              onpressed: () {
                _pickVoiceFromGallery();
              },
            ),
            myButton(buttontext: 'Recents', onpressed: () {}),
            myButton(
              buttontext: 'Record',
              onpressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CameraPage()),
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
