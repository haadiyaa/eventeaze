import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:eventeaze/app/utils/dummydata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

part 'functions_event.dart';
part 'functions_state.dart';

class FunctionsBloc extends Bloc<FunctionsEvent, FunctionsState> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final DummyData dummyData = DummyData();
  final catlist = DummyData.categories;
  String searchNam='';
  // final list = DummyData.events;

  FunctionsBloc() : super(FunctionsInitial()) {
    on<FunctionsEvent>((event, emit) {});
    on<DatePickEvent>(_datePick);
    on<TimePickEvent>(_timePick);
    on<FetchCategoryEvent>(_getCategory);
    on<UploadDummyEvent>(_uploadDummyCategory);
    on<DropdownEvent>(_dropdown);
    on<CreateEventEvent>(_createEvent);
    on<UploadEventImageEvent>(_uploadImage);
    on<UpdateEventEvent>(_updateEvent);
    on<DeleteEvent>(_deleteEvent);
    on<DeleteConfirmEvent>(_deleteConfirmEvent);
    on<DeleteRejectEvent>(_deleteRejectEvent);
    on<SearchEvent>(_searchEvent);
  }

  FutureOr<void> _datePick(DatePickEvent event, Emitter<FunctionsState> emit) {
    emit(DatePickingState());
  }

  Future<FutureOr<void>> _getCategory(
      FetchCategoryEvent event, Emitter<FunctionsState> emit) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('category').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      emit(FetchCategoryState(list: list));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<Uint8List> getImageFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading imagedate: $e';
    }
  }

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = await FirebaseStorage.instance.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'error getting url; $e';
    }
  }

  Future<FutureOr<void>> _uploadDummyCategory(UploadDummyEvent event, Emitter<FunctionsState> emit) async {
    try {
      for( var cat in catlist){
        final file = await getImageFromAssets(cat.image);
        final url=await uploadImageData('categories', file, cat.name);
        cat.image=url;
        await FirebaseFirestore.instance.collection('categories').doc(cat.id).set(cat.toMap());
        emit(UploadedDummyState());
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }

  }

  FutureOr<void> _dropdown(DropdownEvent event, Emitter<FunctionsState> emit) {
    if (event.value != null) {
      print('event value not null');
      emit(DropdownState(value: event.value!));
    } else {
      print('event value null');
    }
  }

  FutureOr<void> _createEvent(
      CreateEventEvent event, Emitter<FunctionsState> emit) {
    emit(CreateLoadingState());
    print('creatint event ');
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        print('user !=null');
        String id = user.uid;
        String eventId = const Uuid().v4();
        FirebaseFirestore.instance.collection('events').doc(eventId).set({
          'eventId': eventId,
          'id': id,
          'eventName': event.event.eventName,
          'eventDate': event.event.eventDate,
          'eventDesc': event.event.eventDesc,
          'eventTime': event.event.eventTime,
          'location': event.event.location,
          'venue': event.event.venue,
          'seats': event.event.seats,
          'contact': event.event.contact,
          'image': event.event.image,
          'category': event.event.category,
          'ticketPrice': event.event.ticketPrice
        });
        emit(CreateEventState());
        print('createdddd');
      } else {
        print('user nullll');
      }
    } catch (e) {
      emit(ErrorState(message: 'errrrroorrr: ${e.toString()}'));
    }
  }

  Future<FutureOr<void>> _uploadImage(
      UploadEventImageEvent event, Emitter<FunctionsState> emit) async {
    emit(LoadingState());
    final ImagePicker imagePicker = ImagePicker();
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();

        Reference referenceRoot = storage.ref();
        Reference refDirImages = referenceRoot.child("images");
        Reference refImageToUpload = refDirImages.child(fileName);

        await refImageToUpload.putFile(File(pickedFile.path));
        String imageUrl = await refImageToUpload.getDownloadURL();
        print('gooottt urlll');
        // await FirebaseFirestore.instance
        //   .collection('events')
        //       .where('id', isEqualTo: event.eventId)
        //       .get()
        //       .then((value) async {
        //     value.docs.forEach((element) {
        //       element.reference.update({'image': imageUrl});
        //     });
        //   });
        emit(UploadEventImageSuccessState(image: imageUrl));
      } else {
        emit(const ErrorState(message: 'not selected'));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      print(e);
    }
  }

  FutureOr<void> _timePick(TimePickEvent event, Emitter<FunctionsState> emit) {
    emit(TimePickState());
  }

  Future<FutureOr<void>> _updateEvent(
      UpdateEventEvent event, Emitter<FunctionsState> emit) async {
    emit(UpdateLoadingState());
    final newEvent = EventModel(
      id: event.event.id,
      eventId: event.event.eventId,
      eventName: event.event.eventName,
      eventDate: event.event.eventDate,
      eventDesc: event.event.eventDesc,
      eventTime: event.event.eventTime,
      location: event.event.location,
      venue: event.event.venue,
      seats: event.event.seats,
      contact: event.event.contact,
      image: event.event.image,
      category: event.event.category,
      ticketPrice: event.event.ticketPrice,
    ).toMap();
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.event.eventId)
          .update(newEvent)
          .then((value) => emit(UpdateEventStete()));
    } catch (e) {
      emit(UpdateEventErrorState(message: e.toString()));
      print(e);
    }
  }

  Future<FutureOr<void>> _deleteEvent(
      DeleteEvent event, Emitter<FunctionsState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .delete()
          .then((value) => emit(DeleteEventState()));
    } catch (e) {
      emit(DeleteEventErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _deleteConfirmEvent(DeleteConfirmEvent event, Emitter<FunctionsState> emit) {
    emit(DeleteConfirmState());
  }

  FutureOr<void> _deleteRejectEvent(DeleteRejectEvent event, Emitter<FunctionsState> emit) {
    emit(DeleteRejectState());
  }

  FutureOr<void> _searchEvent(SearchEvent event, Emitter<FunctionsState> emit) {
    emit(SearchEventState(searchName: event.value));
  }
}
