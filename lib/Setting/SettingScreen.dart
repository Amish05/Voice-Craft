import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_craft/Models/Colors.dart';
import 'package:voice_craft/Provider/theme_changer_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_craft/us/khizar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var nameValue = "";
  int? overallExperience;
  int? recommendApp;
  int? mostValuableFeature;

  void dialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '1. How satisfied are you with the overall user experience of the app?'),
              RadioListTile<int>(
                title: Text('Very Satisfied'),
                value: 5,
                groupValue: overallExperience,
                // selected: ,
                onChanged: (value) {
                  setState(() {
                    overallExperience = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Satisfied'),
                value: 4,
                groupValue: overallExperience,
                onChanged: (value) {
                  setState(() {
                    overallExperience = value;
                  });
                },
              ),
              // Add more RadioListTile widgets for different options

              Text(
                  '2. How likely are you to recommend our app to a friend or colleague?'),
              RadioListTile<int>(
                title: Text('Very Likely'),
                value: 5,
                groupValue: recommendApp,
                onChanged: (value) {
                  setState(() {
                    recommendApp = value;
                  });
                },
              ),
              // Add more RadioListTile widgets for different options

              Text('3. Which feature of the app do you find most valuable?'),
              RadioListTile<int>(
                title: Text('Creative'),
                value: 1,
                groupValue: mostValuableFeature,
                onChanged: (value) {
                  setState(() {
                    mostValuableFeature = value;
                  });
                },
              ),
              // Add more RadioListTile widgets for different options

              // Add similar widgets for questions 4 and 5
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add your logic to handle feedback submission
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString('myName');
    setState(() {
      nameValue = getName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green.shade50
                      : Colors.black45,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Center(
                      child: Text(
                        "Setting",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("images/pretty.png"),
                          radius: 40,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Hello $nameValue",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkGreen
                                    : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  themeDialogBox();
                },
                child: settingItem(Icons.light_mode, "Theme")),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  _showPrivacyPolicyDialog(context);
                },
                child: settingItem(Icons.policy, "Privacy Policy")),
            const SizedBox(height: 15),
            InkWell(
                onTap: () {
                  dialoge(context);
                },
                child: settingItem(Icons.feedback, "Feedback")),
          ],
        ),
      ),
      floatingActionButton:  SizedBox(
        width: 80,
        child: FloatingActionButton(
          foregroundColor: Theme.of(context).brightness == Brightness.light
          ? MyColors.darkGreen
          : Colors.white ,
                      tooltip: "About Us",
                      onPressed: (){ Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Khizar()),
          );} ,
                      child: Center(child: Text("About Us", style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
      ),
    );
  }

  Widget settingItem(IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(Random().nextInt(0xffffffff))
                      .withAlpha(0xff)
                      .withOpacity(.4),
                  borderRadius: BorderRadius.circular(40), //<-- SEE HERE
                ),
                child: Icon(icon),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  themeDialogBox() {
    final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.green.shade50
                : Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("Change Theme",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.darkGreen
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            content: Container(
              height: 180,
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                      title: const Text(
                        "Light Mode",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: ThemeMode.light,
                      groupValue: themeChanger.themeMode,
                      onChanged: (value) {
                        themeChanger.setTheme(value);
                        Navigator.pop(context);
                      }),
                  RadioListTile<ThemeMode>(
                      title: const Text("Dark Mode",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      value: ThemeMode.dark,
                      groupValue: themeChanger.themeMode,
                      onChanged: (value) {
                        themeChanger.setTheme(value);
                        Navigator.pop(context);
                      }),
                  RadioListTile<ThemeMode>(
                      title: const Text("System Mode",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      value: ThemeMode.system,
                      groupValue: themeChanger.themeMode,
                      onChanged: (value) {
                        themeChanger.setTheme(value);
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
  }
}

void _showPrivacyPolicyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Privacy Policy"),
        content: SingleChildScrollView(
          child: Text(
            " Our Image to Story and Story to Image application respects and protects the privacy of our users. We do not collect any personal information without your consent. When you use our application, we may collect non-personal information such as device information, usage data, and technical information to improve our services and user experience. We do not sell, trade, or rent your personal information to third parties. Your data is securely stored and is only used for the purpose of providing and improving our application. If you have any questions or concerns about our privacy policy, please contact us at [creative@gmail.com].",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('I Agree'),
          ),
        ],
      );
    },
  );
}
