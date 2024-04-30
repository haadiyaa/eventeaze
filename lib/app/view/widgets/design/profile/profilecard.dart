
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/view/screens/userdetails_page.dart';
import 'package:eventeaze/app/view/widgets/design/profile/profileavatar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 237, 201),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  child: userData['image'] != null
                      ? ProfileAvatar(
                          child: CachedNetworkImage(
                            imageUrl: userData['image'],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(
                                      255, 180, 192, 142),
                              highlightColor:
                                  const Color.fromARGB(
                                      255, 230, 247, 182),
                              child: Container(
                                width: 10,
                                height: 10,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                        )
                      : ProfileAvatar(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['username'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(
                              255, 68, 73, 53),
                        ),
                      ),
                      Text(
                        userData['email'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: IconButton(
                onPressed: () {
                  final user = UserModel(
                    uid: userData['uid'],
                    email: userData['email'],
                    phone: userData['phone'],
                    username: userData['username'],
                    // image: userData['image'],
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UserDetailsPageWrapper(
                                user: user,
                              )));
                },
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
