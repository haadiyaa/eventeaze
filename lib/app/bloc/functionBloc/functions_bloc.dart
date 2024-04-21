import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/utils/dummydata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

part 'functions_event.dart';
part 'functions_state.dart';

class FunctionsBloc extends Bloc<FunctionsEvent, FunctionsState> {
  final DummyData dummyData=DummyData();
  final list=DummyData.categories;
  FunctionsBloc() : super(FunctionsInitial()) {
    on<FunctionsEvent>((event, emit) {
    });
    on<DatePickEvent>(_datePick);
    on<FetchCategoryEvent>(_getCategory);
    on<UploadDummyEvent>(_uploadDummyCategory);
  }


  FutureOr<void> _datePick(DatePickEvent event, Emitter<FunctionsState> emit) {
    emit(DatePickingState());
  }

  Future<FutureOr<void>> _getCategory(FetchCategoryEvent event, Emitter<FunctionsState> emit) async {
    try {
      final snapshot=await FirebaseFirestore.instance.collection('categories').get();
      final list=snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      emit(FetchCategoryState(list: list));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<Uint8List> getImageFromAssets(String path) async {
    try {
      final byteData=await rootBundle.load(path);
      final imageData=byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading imagedate: $e';
    }
  }

  Future<String> uploadImageData(String path,Uint8List image,String name) async {
    try {
      final ref= await FirebaseStorage.instance.ref(path).child(name);
      await ref.putData(image);
      final url=await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'error getting url; $e';
    }
  }

  Future<FutureOr<void>> _uploadDummyCategory(UploadDummyEvent event, Emitter<FunctionsState> emit) async {
    try {
      for( var category in list){
        final file = await getImageFromAssets(category.image);
        final url=await uploadImageData('categories', file, category.name);
        category.image=url;
        await FirebaseFirestore.instance.collection('categories').doc(category.id).set(category.toMap());
        emit(UploadedDummyState());
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }

  }
}
