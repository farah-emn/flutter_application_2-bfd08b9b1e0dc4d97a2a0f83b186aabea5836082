import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController {
  late String? mobileNumber;
  late String? firstName;
  late String? lastName;
  late String? dateOfBirth;
  late String? nationality;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('user');

  User? user;

  void save(String? mobileNumber, String? firstName, String? lastName,
      String? dateOfBirth, String? nationality) {
    final user = _auth.currentUser;
    final userId = user!.uid.toString();
    this.mobileNumber;
    this.firstName;
    this.lastName;
    this.dateOfBirth;
    this.nationality;
    ref.child(userId).update({
      'mobileNumber': mobileNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
    });
    // Get.
    // ref.update(value);
  }

  Future<String> getUserName() async {
    final user = _auth.currentUser;
    final userId = user!.uid.toString();

    final snapshot = await ref.child(userId).child('user_name').once();
    final userName = snapshot.snapshot.value;
    print(userName.toString());
    return userName.toString();
  }
}
