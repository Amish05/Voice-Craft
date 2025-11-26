import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_craft/Models/Colors.dart';
import 'package:voice_craft/Profile/ProfileScreen.dart';
import 'package:voice_craft/Setting/SettingScreen.dart';
// import 'package:voice_craft/Home_Screen/bootomnavbar.dart';
import 'package:voice_craft/services/card.dart';
import 'package:voice_craft/Home_Screen/home.dart';
import 'package:voice_craft/Login/Login.dart';
// import 'package:voice_craft/Profile/profile_page.dart';
import 'dart:ui';

// import 'package:voice_craft/Setting/setting.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool _isSigningOut = false;

   int currentPageIndex = 0;
   late String mynameValue='' ;
  late String _profilePictureUrl='';
   
int _selectedIndex = 0;
  final _screens = [
    //Home Screen
    const ServiceCard(),

    //Services Screen
    const ProfileScreen(),

    //Setting Screen
    const SettingScreen(),
    
  ];

void getValue() async {
    // var prefs = await SharedPreferences.getInstance();
    // var getName = prefs.getString('myName');

    // if (_getname() != null) {
    //   setState(() {
    //      mynameValue=_getname() ;
    //   });
    // }

    final currentUser = FirebaseAuth.instance.currentUser;
    String currentUserEmail = currentUser!.email!;

    var documentSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(currentUserEmail).get();
    var userData = documentSnapshot.data() as Map<String, dynamic>;
 if (userData.containsKey('Name')) {
      String name = userData['Name'];
      setState(() {
        mynameValue = name;
      });
    } else {
      setState(() {
        mynameValue = '';
      });
    }
    if (userData.containsKey('ProfilePicture')) {
      String imageUrl = userData['ProfilePicture'];
      setState(() {
        _profilePictureUrl = imageUrl;
      });
    } else {
      setState(() {
        _profilePictureUrl = '';
      });
    }
   
  }
 void initState() {
    getValue();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);

    return Scaffold(

 appBar: AppBar(
         elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
       title:
            Text("Hi   ($mynameValue)",style: GoogleFonts.anekOdia(
              textStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light ? MyColors.darkGreen : Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold))),
          actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,10,0),
                child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _profilePictureUrl.isNotEmpty
                    ? Image.network(
                        _profilePictureUrl,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.person_3),
                ),
                            ),
              ),
          ],
      ),


       backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
     bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light ?  Color.fromARGB(146, 46, 89, 99) : Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).brightness == Brightness.light ? Colors.white : MyColors.darkGreen,
            unselectedItemColor: Colors.white60,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            
             selectedIconTheme: IconThemeData(size: 35),
             unselectedIconTheme: IconThemeData(size: 30),

            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded), label: "Profile"),
             
             
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: "Settings"),
            ],
          ),
        ),
     ),
       body: _screens[_selectedIndex],
      drawer: Container(
        height: screenheight / 1.09,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 69, 216, 246),
          child: ProfileScreen(),
        ),
      ),
    );
  }
}
