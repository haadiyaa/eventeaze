import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/view/screens/categoriespage.dart';
import 'package:eventeaze/app/view/screens/createeventpage.dart';
import 'package:eventeaze/app/view/screens/eventlist.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/upcomimgeventpage.dart';
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
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginPageWrapper()));
          // });
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const CreateEventWrapper()));
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
                                      builder: (_) => CategoriesPage()));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //categories
                          EventCategories(),

                          //recommended
                          SectionHeading(
                            title: 'Recommended for you',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const EventList(
                                          title: 'Recommended')));
                            },
                          ),
                          const RecommendedList(),
                          const SizedBox(
                            height: 10,
                          ),
                          SectionHeading(
                            title: 'Upcoming Events',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const UpcomingEventPage(
                                          title: 'Upcoming Events')));
                            },
                          ),
                        ],
                      ),
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
