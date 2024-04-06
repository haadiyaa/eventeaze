import 'package:eventeaze/app/bloc/dotBloc/dotindicator_bloc.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/splashscreen.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/onboard/dotindicator.dart';
import 'package:eventeaze/app/view/widgets/onboard/onboardcontent.dart';
import 'package:eventeaze/app/view/widgets/onboard/onboardwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingWrapper extends StatelessWidget {
  const OnBoardingWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DotindicatorBloc(),
      child: const OnBoardingScreen(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = OnBoardItems();
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DotindicatorBloc, DotindicatorState>(
          builder: (context, state) {
            return Column(
              children: [
                const Image(image: AssetImage('assets/onboardingmage.png')),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (value) {
                      state.page = value;
                      BlocProvider.of<DotindicatorBloc>(context)
                          .add(DotindicatorEvent());
                      print('index of page is ${value}');
                    },
                    itemCount: controller.data.length,
                    controller: pageController,
                    itemBuilder: (context, index) => OnboardContent(
                      title: controller.data[index].title,
                      desc: controller.data[index].desc,
                    ),
                  ),
                ),
                state.page != controller.data.length - 1
                    ? CustomButton(
                        text: 'Next',
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        color: Color.fromARGB(255, 93, 100, 73),
                      )
                    : CustomButton(
                        text: 'Get Started',
                        onPressed: () async {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => LoginPageWrapper()));
                              var sharedPref=await SharedPreferences.getInstance();
                              sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
                        },
                        color: const Color.fromARGB(255, 93, 100, 73),
                      ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      controller.data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DotIndicator(
                          isActive: index == state.page,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => LoginPageWrapper()));
                          },
                          child: const Text('Skip')),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
