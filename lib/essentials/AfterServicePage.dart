import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voice_craft/essentials/CameraPage.dart';
import 'package:voice_craft/essentials/button.dart';

class AfterServicePage extends StatefulWidget {
  const AfterServicePage({super.key});

  @override
  State<AfterServicePage> createState() => _AfterServicePageState();
}

class _AfterServicePageState extends State<AfterServicePage> {
   Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Do something with the picked image file (e.g., display or upload)
        print("Image picked from gallery: ${pickedFile.path}");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
        double screenwidth=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 5, 33, 48),
      appBar: AppBar(
        leading:IconButton( onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back)),   title: Text('Voice Craft', style: TextStyle(fontWeight: FontWeight.bold),),
                backgroundColor: Color.fromARGB(255, 69, 216, 246),

),
       body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                          // fontFamily: 'SEASRN',
                          fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            
           myButton(buttontext: 'Import', onpressed: (){
                _pickImageFromGallery();
             
           }),
           myButton(buttontext: 'Recents', onpressed: (){}),
           myButton(buttontext: 'Record', onpressed: (){
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  CameraPage()
            ),
          );
          
           }),
           myButton(buttontext: 'Clear Data', onpressed: (){}),
         
          ],
        ),
      ),
    );
  }
}