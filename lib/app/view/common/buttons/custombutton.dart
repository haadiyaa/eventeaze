import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed,this.color,this.foreground, this.child});
  final String text;
  final Color? color;
  final Color? foreground;
  final void Function()? onPressed;
  final Widget? child;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.075,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor:foreground??Colors.white,
          backgroundColor: color,
        ),
        child: child??Text(
          text,
          style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        // child: Text(
        //   text,
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        // ),
      ),
    );
  }
}
