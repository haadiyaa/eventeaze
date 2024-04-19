import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/screens/categoriespage.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/widgets/buttons/sectionheading.dart';
import 'package:eventeaze/app/view/widgets/design/eventcategorieslist.dart';
import 'package:eventeaze/app/view/widgets/design/recommendedlist.dart';
import 'package:eventeaze/app/view/widgets/design/upcominglist.dart';
import 'package:eventeaze/app/view/widgets/textfields/customsearchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginPageWrapper()));
          });
        } else if (state is AuthLoadingState) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: SpinKitFadingCircle(
                  duration: Duration(seconds: 2),
                  color: Colors.white,
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: CustomSearchBar(
              onTap: () {},
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_to_photos_rounded,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                  ),
                  child: Column(
                    children: [
                      SectionHeading(
                        title: 'Categories',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CategoriesPage()));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //categories
                      const EventCategories(),

                      //recommended
                      SectionHeading(
                        title: 'Recommended for you',
                        onPressed: () {},
                      ),
                      const RecommendedList(),
                      const SizedBox(
                        height: 10,
                      ),
                      SectionHeading(
                        title: 'Upcoming Events',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const UpcomingList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
