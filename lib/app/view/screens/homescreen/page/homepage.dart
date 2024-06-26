import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/view/screens/categoriesscreen/page/categoriespage.dart';
import 'package:eventeaze/app/view/screens/createevent/page/createeventpage.dart';
import 'package:eventeaze/app/view/screens/eventlist.dart';
import 'package:eventeaze/app/view/screens/homescreen/page/freeeventspage.dart';
import 'package:eventeaze/app/view/screens/authentication/login/page/login_page.dart';
import 'package:eventeaze/app/view/screens/homescreen/page/searcheventpage.dart';
import 'package:eventeaze/app/view/screens/homescreen/page/upcomimgeventpage.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/sectionheading.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/eventcategorieslist.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/mybanner.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/recommendedlist.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/upcominglist.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/customsearchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => FunctionsBloc(),
        ),
      ],
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel>? allCategory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const LoginPageWrapper()));
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchEventWrapper()));
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CreateEventWrapper()));
                },
                icon: const Icon(
                  Icons.add_to_photos_rounded,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<FunctionsBloc, FunctionsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: MyBanner(
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>FreeEventsPage()));},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 15,
                          ),
                          child: SectionHeading(
                            title: 'Categories',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CategoriesPage()));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const EventCategories(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 15,
                          ),
                          child: SectionHeading(
                            title: 'Recommended for you',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EventList(title: 'Recommended'),
                                ),
                              );
                            },
                          ),
                        ),
                        const RecommendedList(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 15,
                          ),
                          child: SectionHeading(
                            title: 'Upcoming Events',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const UpcomingEventPage(
                                      title: 'Upcoming Events'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    UpcomingList(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
