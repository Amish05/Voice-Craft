import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
     final String buttontext; 
   final VoidCallback onpressed ;
  const myButton({Key? key, required this.buttontext, required this.onpressed}):super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return Padding(
               padding: const EdgeInsets.fromLTRB(9.0,16,9,6),
               child: SizedBox(
                       width: screenwidth-10 , // Set the desired width
                       child: ElevatedButton(
                onPressed:onpressed ,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 108, 234, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set the border radius
                  ),
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,15),
                  child: Text(buttontext,style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(231, 18, 89, 130), fontSize: 20),),
                ),
                       ),
                     ),
             );
  }
}