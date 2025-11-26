import 'package:flutter/material.dart';
class LipReading extends StatefulWidget {
  const LipReading({super.key});

  @override
  State<LipReading> createState() => _LipReadingState();
}

class _LipReadingState extends State<LipReading> {
  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
       backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade50
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(leading: IconButton(onPressed: (){  Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),),
      body: Column(
        children: [
           Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(08, 18, 08, 0),
                  child: Text(
                    "VOICE  CRAFT",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.amber,
                        fontFamily: 'SEASRN',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(08, 0, 08, 25),
                  child: Text(
                    "THE AUDIO GENERATOR",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'kaushan',
                        color: Colors.amber,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
     
  }
}