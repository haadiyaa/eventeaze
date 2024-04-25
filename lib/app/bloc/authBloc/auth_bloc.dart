import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const KEYLOGIN = 'login';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>(_checkStatus);
    on<OnboardEvent>(_onBoard);
    on<LoginEvent>(_logIn);
    on<SignUpEvent>(_signUp);
    on<LogOutEvent>(_logOut);
    on<LogoutConfirmEvent>(_logOutConfirm);
    on<LogoutRejectEvent>(_logOutReject);
    on<ForgotPassEvent>(_forgotPass);
    on<ResetConfirmEvent>(_resetConfirm);
    on<UpadateUserEvent>(_updateUser);
    on<GoogleSignInEvent>(_googleSignIn);
    on<UserImagePickEvent>(_imagePick);
  }

  Future<void> _onBoard(OnboardEvent event, Emitter<AuthState> emit) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(KEYLOGIN, false);
    emit(GetStartedState());
  }

  Future<void> _checkStatus(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    User? user;
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    try {
      await Future.delayed(const Duration(seconds: 3));
      if (isLoggedIn == null) {
        emit(GetStartedState());
      } else {
        user = _auth.currentUser;
        if (user != null) {
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnAuthenticatedState());
        }
      }
    } catch (e) {
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _logIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      print('loggin in process');
      userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final user = userCredential.user;
      print('login successful');
      if (user != null) {
        emit(AuthenticatedState(user: user));
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(KEYLOGIN, true);
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    print('loading');
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user.email.toString(),
          password: event.user.password.toString());
      print('created user');

      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'phone': event.user.phone,
          'username': event.user.username,
          // 'image':event.user.image,
        });
        print('authenticated');
        emit(AuthenticatedState(user: userCredential.user!));
      } else {
        print('unauthenticated');
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      print('authentication errorr1!!!!!!!!!');
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _auth.signOut().then((value) {
        emit(UnAuthenticatedState());
      });
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(KEYLOGIN, false);
    } catch (e) {
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _forgotPass(
      ForgotPassEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _auth
          .sendPasswordResetEmail(email: event.email)
          .then((value) => emit(ForgotPassState()));
    } catch (e) {
      emit(PasswordResetErrorState(message: e.toString()));
    }
  }

  Future<void> _resetConfirm(
      ResetConfirmEvent event, Emitter<AuthState> emit) async {
    emit(ResetConfirmState());
  }

  FutureOr<void> _logOutConfirm(
      LogoutConfirmEvent event, Emitter<AuthState> emit) {
    emit(LogoutConfirmState());
  }

  Future<FutureOr<void>> _updateUser(
      UpadateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final newUser = UserModel(
      uid: event.user.uid,
      username: event.user.username,
      email: event.user.email,
      phone: event.user.phone,
      // image: event.user.image,
    ).toMap();
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.user.uid)
          .update(newUser)
          .then((value) => emit(UpdateUserState()));
    } catch (e) {
      emit(UpdationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _logOutReject(
      LogoutRejectEvent event, Emitter<AuthState> emit) {
    emit(LogoutRejectState());
  }

  Future<FutureOr<void>> _googleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    print('google sign in');
    emit(AuthLoadingState());
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        print('$googleUser != Null');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        
        final user = userCredential.user;
        if (user != null) {
          await saveUserDataToFirestore(user);
          print('user Not null');
          emit(GoogleSignInState(user: user));
        } else {
          print('user Null');
          emit(GoogleSignInErrorState(message: 'Errroorrr: user null'));
        }
        
      } else {
        print('$googleUser ====== == NUll');
        emit(GoogleSignInErrorState(message: 'Gooogle user nulll'));
      }
    } catch (e) {
      print('errror');
      emit(GoogleSignInErrorState(message: e.toString()));
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot docSnapshot = await userCollection.doc(user.uid).get();

      if (!docSnapshot.exists) {
        await userCollection.doc(user.uid).set({
          'username': user.displayName,
          'email': user.email,
          'phone':'',
          'uid':user.uid,
        });
      }
    } catch (e) {
      print('Error saving user data to Firestore: $e');
    }
  }

  Future<FutureOr<void>> _imagePick(UserImagePickEvent event, Emitter<AuthState> emit) async {
    emit(ImageLoadingState());

    final ImagePicker imagePicker=ImagePicker();
    try {
      String fileName=DateTime.now().millisecondsSinceEpoch.toString();
      final pickedFile= await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile!=null) {
        final bytes=await pickedFile.readAsBytes();
        Reference reference=FirebaseStorage.instance.ref().child('user_profile');
        Reference ref=reference.child(fileName);
        await ref.putFile(File(pickedFile.path));
        String imageurl=await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: event.email).get().then((value) {
          value.docs.forEach((element) { 
            element.reference.update({'image':imageurl});
          });
        });
        emit(UserImagePickState(image: imageurl));
      }
      emit(ImagePickErrorState(message: 'Did not Pick Image'));
    } catch (e) {
      emit(ImagePickErrorState(message: e.toString()));
    }
  }
}
