
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {

  void initializeInstances();

  Future<void> signInUserWithEmailAndPassword({ required String email ,
    required String password,
    required String mobile,
    required String name});

  Future<void> loginInUserWithEmailAndPassword({
    required String email ,
    required String password,
  });

}

class AuthService extends AuthRepository {

  late FirebaseAuth auth;
  late FirebaseFirestore firestore;


  @override
  void initializeInstances() {
    // TODO: implement initializeInstances
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  @override
  Future<void> loginInUserWithEmailAndPassword({required String email, required String password}) async {
    // TODO: implement loginInUserWithEmailAndPassword
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    } on Exception catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInUserWithEmailAndPassword({required String email, required String password, required String mobile, required String name}) async{
    // TODO: implement signInUserWithEmailAndPassword
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    } on Exception catch(e) {
      throw Exception(e);
    }

  }

  void logoutCurrentUser(){
    auth.signOut();
  }

}