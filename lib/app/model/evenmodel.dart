import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  String id;
  String eventName;
  String eventDate;
  String eventDesc;
  String eventTime;
  String location;
  String venue;
  String seats;
  String contact;
  String image;
  String category;
  EventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.eventDesc,
    required this.eventTime,
    required this.location,
    required this.venue,
    required this.seats,
    required this.contact,
    required this.image,
    required this.category,
  });

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'eventName': eventName,
      'eventDate': eventDate,
      'eventDesc': eventDesc,
      'eventTime': eventTime,
      'location': location,
      'venue': venue,
      'seats': seats,
      'contact': contact,
      'image': image,
      'category': category,
    };
  }

  factory EventModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    if (map.data() != null) {
      final data = map.data()!;
      return EventModel(
        id: map.id,
        eventName: data['eventName'] ?? '',
        eventDate: data['eventDate'] ?? '',
        eventDesc: data['eventDesc'] ?? '',
        eventTime: data['eventTime'] ?? '',
        location: data['location'] ?? '',
        venue: data['venue'] ?? '',
        seats: data['seats'] ?? '',
        contact: data['contact'] ?? '',
        image: data['image'] ?? '',
        category: data['category'] ?? '',
      );
    }else{
      return EventModel(
      id:  '',
      eventName: '',
      eventDate:  '',
      eventDesc:  '',
      eventTime:  '',
      location:  '',
      venue:  '',
      seats:  '',
      contact:  '',
      image:  '',
      category:  '',
    );
    }
    
  }
}
