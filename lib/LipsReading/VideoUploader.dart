import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:voice_craft/Models/Colors.dart';

class VideoUploader extends StatefulWidget {
  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  File? _video;
  final picker = ImagePicker();
  String? _prediction;
  VideoPlayerController? _videoPlayerController;
  bool _isLoading = false;

  Future<void> _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        _initializeVideoPlayer();
      }
    });
  }

  void _initializeVideoPlayer() {
    if (_video != null) {
      _videoPlayerController = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.setVolume(0); // Mute by default
          _videoPlayerController!.play();
        });
    }
  }

  void _replayVideo() {
    _videoPlayerController!.seekTo(Duration.zero);
    _videoPlayerController!.play();
  }

  Future<void> _uploadVideo() async {
    if (_video == null) return;
    setState(() {
      _isLoading = true;
      _prediction = null; // Clear the existing prediction
    });
    print('Video button clicked');
    final request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.18.52:8000/predict/"));
    request.files.add(await http.MultipartFile.fromPath('file', _video!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      setState(() {
        _prediction = decodedResponse['prediction'];
        print(_prediction);
      });
    } else {
      print("Error uploading video: ${response.statusCode}");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Read Lips",
          style: GoogleFonts.anekOdia(
            textStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColors.darkGreen
                  : Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_video != null && _videoPlayerController != null)
              Column(
                children: [
                  Container(
                    height: screenHeight / 3,
                    width: screenWidth - 50,
                    decoration: BoxDecoration(),
                    child: VideoPlayer(_videoPlayerController!),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: _replayVideo,
                      ),
                      IconButton(
                        icon: Icon(Icons.video_library),
                        onPressed: _pickVideo,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _uploadVideo,
                          child: Text('Upload Video'),
                        ),
                ],
              )
            else
              InkWell(
                onTap: () {
                  _pickVideo();
                },
                child: Container(
                  height: screenHeight / 3 - 35,
                  width: screenWidth - 20,
                  child: Card(
                    shadowColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Color.fromARGB(146, 46, 89, 99)
                            : Color.fromARGB(35, 255, 255, 255),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Color.fromARGB(146, 46, 89, 99),
                    elevation: 10.0,
                    margin: EdgeInsets.all(7.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white,
                            size: 100,
                          ),
                          Text("Pick a Video",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MyColors.darkGreen
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (_prediction != null)
              Text(
                '$_prediction',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
