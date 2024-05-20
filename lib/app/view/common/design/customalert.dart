import 'package:eventeaze/app/view/common/buttons/custombutton.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          icon: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 98, 219, 125),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:const Color.fromARGB(255, 50, 51, 51).withOpacity(0.2),
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.done,color: Colors.white,size:60,),
          ),
          title: const Text(
            'We’ve send you a\nlink to your mail.\nPlease check and complete the process.',
            style: TextStyle(
              color: Color.fromARGB(255, 68, 73, 53),
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            CustomButton(
              text: 'OK',
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
              color: const Color.fromARGB(255, 170, 181, 135),
            ),
          ],
        ),
      ),
    );
  }
}
