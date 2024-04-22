import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  String? eventId;
  String? id;
  String? eventName;
  String? eventDate;
  String? eventDesc;
  String? eventTime;
  String? location;
  String? venue;
  String? seats;
  String? contact;
  String? image;
  String? category;
  EventModel({
    this.id,
    this.eventName,
    this.eventDate,
    this.eventDesc,
    this.eventTime,
    this.location,
    this.venue,
    this.seats,
    this.contact,
    this.image,
    this.category,
    this.eventId,
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
      'eventId':eventId,
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
        eventTime: data['eventTime'] ?? DateTime.now(),
        location: data['location'] ?? '',
        venue: data['venue'] ?? '',
        seats: data['seats'] ?? '',
        contact: data['contact'] ?? '',
        image: data['image'] ?? '',
        category: data['category'] ?? '',
        eventId: data['eventId']?? '',
      );
    }else{
      return EventModel(
        eventId: '',
      id:  '',
      eventName: '',
      eventDate: '',
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
