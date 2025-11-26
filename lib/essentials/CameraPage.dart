import 'dart:io'; // Import this for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage; // Variable to store the picked image file

  Future<void> _openCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Store the picked image file
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture the Moment', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 69, 216, 246),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 5, 33, 48),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_pickedImage != null) // Display the picked image if available
                  Image.file(
                    _pickedImage!,
                    width: MediaQuery.of(context).size.width-10,
                    height: (MediaQuery.of(context).size.height)-180,
                    fit: BoxFit.fill,
                  ),
                   SizedBox(height: 20),
                if (_pickedImage == null)
                Align(
                alignment: Alignment.bottomCenter,
                 child:
                     
                      
                 FloatingActionButton(onPressed: _openCamera,  child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      
                      color: Color.fromARGB(255, 5, 33, 48),
                    ),  backgroundColor: Color.fromARGB(255, 253, 253, 253),),
                    
                   ),
                 if (_pickedImage != null)
                   Align(
                alignment: Alignment.bottomCenter,
                 child: Column(
                  
                    children: [
                      
                      //  SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: FloatingActionButton(onPressed: _openCamera,  child: Icon(
                            Icons.camera_alt,
                            size: 30,
                            
                            color: Color.fromARGB(255, 5, 33, 48),
                          ),  backgroundColor: Color.fromARGB(255, 253, 253, 253),),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: FloatingActionButton(onPressed: _openCamera,  child: Icon(
                            Icons.send,
                            size: 30,
                            
                            color: Color.fromARGB(255, 5, 33, 48),
                          ),  backgroundColor: Color.fromARGB(255, 253, 253, 253),),
                     ),
                   ],
                 ),
                    
                    ],
                  ),),
                // Container(
                //   width: 150,
                //   height: 150,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.3),
                //         spreadRadius: 2,
                //         blurRadius: 8,
                //         offset: Offset(0, 5),
                //       ),
                //     ],
                //   ),
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.camera_alt,
                //       size: 50,
                //       color: Color.fromARGB(255, 5, 33, 48),
                //     ),
                //     onPressed: _openCamera,
                //   ),
                // ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
