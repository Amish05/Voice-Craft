import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../helper/image_classification_helper.dart';

class GalleryScreenEmotion extends StatefulWidget {
  const GalleryScreenEmotion({Key? key}) : super(key: key);

  @override
  State<GalleryScreenEmotion> createState() => _GalleryScreenEmotionState();
}

class _GalleryScreenEmotionState extends State<GalleryScreenEmotion> {
  ImageClassificationHelper? imageClassificationHelper;
  final imagePicker = ImagePicker();
  String? imagePath;
  img.Image? image;
  Map<String, double>? classification;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();

    // Call pick image method when widget initializes
    _pickImageFromGallery();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });

      // Process the image after it's picked
      await processImage();
    }
  }

  void cleanResult() {
    imagePath = null;
    image = null;
    classification = null;
    setState(() {});
  }

  Future<void> processImage() async {
    if (imagePath != null) {
      final imageData = File(imagePath!).readAsBytesSync();
      image = img.decodeImage(imageData);
      setState(() {});
      classification = await imageClassificationHelper?.inferenceImage(image!);
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Emotion"),
          backgroundColor: Color.fromARGB(255, 69, 216, 246),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: Column(
              children: [
                if (imagePath != null)
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                        15.0, 15.0, 15.0, 0), // Adjust top padding
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(imagePath!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                if (image == null && imagePath == null)
                  const Text(
                    "Take a photo or choose one from the gallery to inference.",
                  ),
                Column(
                  children: [
                    if (classification != null)
                      ...(classification!.entries.toList()
                            ..sort(
                              (a, b) => a.value.compareTo(b.value),
                            ))
                          .reversed
                          .take(1)
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    e.key,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const Spacer(),
                                  Text(
                                    e.value.toStringAsFixed(1),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
