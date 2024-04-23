import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/model/evenmodel.dart';

class DummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1',
        name: 'Sports',
        image: 'assets/categories/sports.jpg',
        isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Family',
        image: 'assets/categories/family.jpg',
        isFeatured: true),
    CategoryModel(
        id: '3',
        name: 'Art',
        image: 'assets/categories/arts.jpg',
        isFeatured: true),
    CategoryModel(
        id: '4',
        name: 'Music',
        image: 'assets/categories/music.jpg',
        isFeatured: true),
    CategoryModel(
        id: '5',
        name: 'Business',
        image: 'assets/categories/business.jpg',
        isFeatured: true),
  ];

  // static final List<EventModel> events = [
  //   EventModel(
  //     id: '1',
  //     eventName: 'Sports',
  //     eventDate: '7/5/2024',
  //     eventDesc:
  //         '''Sporting event means an athletic activity requiring skill or physical prowess, usually competitive in nature and governed by a set of rules provided by a nationally recognized sanctioning body or by a local organization engaged in the development and active promotion of the athletic activity.''',
  //     eventTime: '2 PM to 5 PM',
  //     location: 'Calicut',
  //     venue: 'Stadium',
  //     seats: '100',
  //     contact: '8907654256',
  //     image: 'assets/events/sports.jpg',
  //     category: 'Sports',
  //   ),
  //   EventModel(
  //     id: '2',
  //     eventName: 'Arts show',
  //     eventDate: '11/5/2024',
  //     eventDesc:
  //         '''This dynamic event celebrates the rich diversity of arts and culture from around the globe, bringing together artists, performers, and cultural enthusiasts for a vibrant and immersive experience''',
  //     eventTime: '2 PM to 5 PM',
  //     location: 'Mumbai',
  //     venue: 'Art Gallery',
  //     seats: '500',
  //     contact: '7896543567',
  //     image: 'assets/events/arts.jpg',
  //     category: 'Art',
  //   ),
  //   EventModel(
  //     id: '3',
  //     eventName: 'Business',
  //     eventDate: '2/10/2024',
  //     eventDesc:
  //         '''Business events are large gatherings where professionals carry out business-related activities, such as selling services, conducting research or meeting clients. These events often blend leisure with professional activities, such as debates or exhibitions.''',
  //     eventTime: '7 PM',
  //     location: 'Bangalore',
  //     venue: 'Technologies',
  //     seats: '50',
  //     contact: '7896543567',
  //     image: 'assets/events/business.jpg',
  //     category: 'Business',
  //   ),
  // ];
}
