import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_craft/LipsReading/VideoUploader.dart';
import 'package:voice_craft/Models/Colors.dart';
import 'package:voice_craft/Sound_ide/Sound_ide_page.dart';
import 'package:voice_craft/emotion/emotionpage.dart';
import 'package:voice_craft/essentials/AfterServicePage.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({Key? key});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      

       backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => VideoUploader()),
                        );
                      },
                      child: Container(
                        height: screenHeight / 2 - 35,
                        width: screenWidth / 2 - 3,
                        child: Card(
                          color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          :Color.fromARGB(146, 46, 89, 99),
                          elevation: 10.0,
                          margin: EdgeInsets.all(07.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/lipreading.webp',
                                  fit: BoxFit.fill,
                                  height: 120.0,
                                ),
                                ListTile(
                                  title: Text(
                                    'Read Lips',
                                   style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold))),
                                  subtitle: Text('Lip Reading to Text',style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold))),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(16.0),
                                //   child: Text(
                                //     'Experience luxury and style like never before with the Elegance 2023. ',
                                //     style: TextStyle(fontSize: 16.0),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            
             InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Sound_ide_page()),
                        );
                      },
                      child: Container(
                        height: screenHeight / 2 - 35,
                        width: screenWidth / 2 - 3,
                        child: Card(
                         color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          :Color.fromARGB(146, 46, 89, 99),
                          elevation: 10.0,
                          margin: EdgeInsets.all(07.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/sound.webp',
                                  fit: BoxFit.fill,
                                  height: 120.0,
                                ),
                                ListTile(
                                  title: Text(
                                    'Identify Sound',
                                    style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
                                  ),
                                  subtitle: Text('Strange Voices? Let\'s identify.',style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold))),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(16.0),
                                //   child: Text(
                                //     'Experience luxury and style like never before with the Elegance 2023. ',
                                //     style: TextStyle(fontSize: 16.0),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            
                  ],
                ),
              
            
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => emotionpage()),
                        );
                      },
                      child: Container(
                        height: screenHeight / 3 - 35,
                        width: screenWidth-20 ,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child:Card(
                           color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          :Color.fromARGB(146, 46, 89, 99),
                          elevation: 10.0,
                          margin: EdgeInsets.all(07.0),
                          child: SingleChildScrollView(
                            child: Row(
                              
                              children: [
                                 Image.asset(
                                  'images/emotion.jpg',
                                  fit: BoxFit.cover,
                                  width: screenWidth / 3 ,
                                  height: screenHeight/3-35,

                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                  Text("Recognize Emotions",style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.darkGreen 
                        : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
                                  Text("Don\'t Know what Emotions",style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold))),
                                  Text(" you are in?",style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold)))

                                ],),
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToServiceCard(BuildContext context) async {
    // Request camera and microphone permissions
    final permissionStatus = await Permission.camera.request();
    final microphoneStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted && microphoneStatus.isGranted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ServiceCard()),
      );
    } else {
      // Handle case where permissions are not granted
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Required'),
          content: Text('Camera and microphone permissions are required.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
