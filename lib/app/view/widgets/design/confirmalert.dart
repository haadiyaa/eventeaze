import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:flutter/material.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert(
      {super.key,
      required this.msg,
      this.iconBgColor,
      this.iconColor,
      required this.icon,
      required this.onConfirm,
      required this.onReject});

  final String msg;
  final Color? iconBgColor;
  final Color? iconColor;
  final IconData icon;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          icon: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 50, 51, 51).withOpacity(0.2),
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 60,
            ),
          ),
          title: Text(
            msg,
            style: const TextStyle(
              color: Color.fromARGB(255, 68, 73, 53),
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            CustomButton(
              text: 'Yes',
              onPressed: onConfirm,
              color: const Color.fromARGB(255, 138, 148, 108),
            ),
            CustomButton(
              text: 'No',
              foreground: const Color.fromARGB(255, 138, 148, 108),
              onPressed: onReject,
              color: const Color.fromARGB(255, 233, 237, 201),
            ),
          ],
        ),
      ),
    );
  }
}
