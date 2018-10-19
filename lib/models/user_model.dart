import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userDate = Map();

  bool isLoading = false;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void singUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess,
    @required VoidCallback onFail}) {
      this.isLoading = true;
      notifyListeners();

      _auth.createUserWithEmailAndPassword(
          email: userData["email"],
          password: pass
      ).then((user) async{
        firebaseUser = user;

        await _saveUserData(userData);
        onSuccess();
        this.isLoading = false;
        notifyListeners();
      }).catchError((){
        onFail();
        this.isLoading = false;
        notifyListeners();
      });
  }

  void singIn({@required String email, @required String pass, @required VoidCallback onSuccess,
    @required VoidCallback onFail}) async{

    this.isLoading = true;
    notifyListeners();
    
    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
     (user) async{
        firebaseUser = user;

        await _loadCurrentUser();

        onSuccess();
        this.isLoading = false;
        notifyListeners();
    }).catchError((){
      onFail();
      this.isLoading = false;
      notifyListeners();
    });

    this.isLoading = false;
    notifyListeners();
  }

  void singOut() async{
    await _auth.signOut();
    userDate = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

   bool isLoggedin() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{

    this.userDate = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null) {
      if(userDate["name"] == null) {
        DocumentSnapshot docUser = 
            await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userDate = docUser.data;
      }
    }
    notifyListeners();
  }

}