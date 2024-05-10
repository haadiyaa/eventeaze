import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.eventdata,
  });

  final Map<String, dynamic> eventdata;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: const Color.fromARGB(255, 27, 59, 29),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: eventdata['image'],
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 10,
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              eventdata['eventName'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                '${DateFormat("dd MMM yyyy 'at' hh:mm a").format(eventdata['eventDate'].toDate())}, ${eventdata['eventTime']}'),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${eventdata['venue']}, ${eventdata['location']}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            eventdata['price']==''?const SizedBox():
            Text(
              "Amount: ${eventdata['price']}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat("dd MMM yyyy 'at' hh:mm a")
                  .format(eventdata['bookingTime'].toDate()),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 4,
            ),
            CustomButton(
              text: 'Veiw Details',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EventDetailsPage(
                              id: eventdata['eventId'],
                            )));
              },
              color: const Color.fromARGB(255, 68, 73, 53),
            ),
          ],
        ),
      ),
    );
  }
}
