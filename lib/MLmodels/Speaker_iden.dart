import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> downloadModel(String modelname) async {
  // Specify the name of the model
  String modelName = modelname;

  FirebaseModelDownloadConditions conditions = FirebaseModelDownloadConditions(
    // Download whilst connected to cellular data
    iosAllowsCellularAccess: true,
    // Allow downloading in the background
    iosAllowsBackgroundDownloading: true,
    // Only download whilst charging
    androidChargingRequired: true,
    // Only download whilst on Wifi
    androidWifiRequired: true,
    // Only download whilst the device is idle
    androidDeviceIdleRequired: false,
  );
  // Download the model from Firebase
  FirebaseCustomModel model = await FirebaseModelDownloader.instance
      .getModel(modelName, FirebaseModelDownloadType.latestModel, conditions);
  // Get the file path of the downloaded model
  String modelFilePath = model.file.path;

  // Get the application directory
  Directory appDir = await getApplicationDocumentsDirectory();

  // Create a new directory to store the model
  Directory modelDir = Directory('${appDir.path}/$modelName/');
  await modelDir.create();

  // Move the model to the new directory
  File(modelFilePath).copy('${modelDir.path}/$modelName.tflite');
  String labelFilePath =
      'https://firebasestorage.googleapis.com/v0/b/voice-craft-264b3.appspot.com/o/labels%2Flabels_Sound.txt?alt=media&token=7ca50b80-e9cb-4802-b653-77e1cf167450';

  Directory labelDir = Directory('${appDir.path}/labels/');
  await labelDir.create();

  // Download the label file from Firebase Storage
  File labelFile = File('${labelDir.path}/labels.txt');
  await FirebaseStorage.instance.ref(labelFilePath).writeToFile(labelFile);
  print(labelFile);
}
