import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrivacyDesc(
                title: 'Personal Identification Information',
                body:
                    'We may collect personal identification information from Users in various ways, including, but not limited to, when Users visit our App, register on the App, place an order, subscribe to the newsletter, respond to a survey, fill out a form, and in connection with other activities, services, features, or resources we make available on our App. Users may be asked for, as appropriate, name, email address, mailing address, phone number, and credit card information. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain App-related activities.',
              ),
              SizedBox(height: 10,),
              PrivacyDesc(title: 'How We Protect Your Information', body: 'We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information, username, password, transaction information, and data stored on our App.'),
              SizedBox(height: 10,),
              PrivacyDesc(title: 'How We Protect Your Information', body: 'By using this App, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our App. Your continued use of the App following the posting of changes to this policy will be deemed your acceptance of those changes.')
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyDesc extends StatelessWidget {
  const PrivacyDesc({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  Color.fromARGB(200, 68, 73, 53)),
        ),
        const SizedBox(height: 8,),
        Text(
          body,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 68, 73, 53)
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
