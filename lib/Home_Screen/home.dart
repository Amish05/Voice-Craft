import 'package:flutter/material.dart';
import 'package:voice_craft/us/amish.dart';
import 'package:voice_craft/us/ashar.dart';
import 'package:voice_craft/us/khizar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: screenWidth,
            //   decoration: BoxDecoration(
            //     color: Color.fromARGB(255, 69, 216, 246),
            //   ),
            //   child: const Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(08, 18, 08, 0),
            //         child: Text(
            //           "VOICE  CRAFT",
            //           style: TextStyle(
            //               fontSize: 40,
            //               color: Color.fromARGB(255, 255, 255, 255),
            //               // fontFamily: 'SEASRN',
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(08, 0, 08, 25),
            //         child: Text(
            //           "THE AUDIO GENERATOR",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontFamily: 'kaushan',
            //               color: Color.fromARGB(255, 255, 255, 255),
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,),
              child: Column(
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('images/logo.png')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(08, 02, 08, 0),
                    child: Text(
                      "CO-FOUNDERS",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // CircleAvatar(
                        //   backgroundColor:Colors.amber,
                        //   backgroundImage: AssetImage('images/logo.png'),
                        //   radius: 60,
      
                        //    ),
                       
      
                      Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Khizar()),
                        );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Color.fromARGB(255, 192, 236, 245),
                              backgroundImage: AssetImage('images/khizar.png'),
                            ),
                            SizedBox(
                                height:
                                    10), // Adjust the spacing between CircleAvatar and Text
                            Text(
                              'Khizar Hayat', // Replace with the desired name
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Amish()),
                        );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Color.fromARGB(255, 192, 236, 245),
                              backgroundImage: AssetImage('images/Amish.png'),
                            ),
                            SizedBox(
                                height:
                                    10), // Adjust the spacing between CircleAvatar and Text
                            Text(
                              'Amish Ali', // Replace with the desired name
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      
      
      
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ashar()),
                        );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Color.fromARGB(255, 192, 236, 245),
                              backgroundImage: AssetImage('images/Ashar.png'),
                            ),
                            SizedBox(
                                height:
                                    10), // Adjust the spacing between CircleAvatar and Text
                            Text(
                              'Ashar Khan', // Replace with the desired name
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
