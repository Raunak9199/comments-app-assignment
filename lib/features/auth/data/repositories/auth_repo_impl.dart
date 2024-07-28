import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments_app_assignment/core/constants.dart';
import 'package:comments_app_assignment/features/auth/data/models/user_model.dart';
import 'package:comments_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:comments_app_assignment/features/auth/domain/repository/auth_repo_interface.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  AuthRepositoryImpl({
    required this.firestore,
    required this.firebaseAuth,
    required this.storage,
  });
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage storage;

  Future<void> uploadData(UserEntity user) async {
    final snap = firestore.collection(AppConstants.login);

    final uid = await getCurrentUserUid();

    snap.doc(uid).get().then((newuser) {
      final newUser = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
      ).toJson();
      if (newuser.exists) {
        snap.doc(uid).update(newUser);
      } else {
        snap.doc(uid).set(newUser, SetOptions(merge: true));
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: "$error");
      log("$error");
    });
  }

  @override
  Future<String> getCurrentUserUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getCurrentUserData(String uid) {
    final userSnapshot = firestore
        .collection(AppConstants.login)
        .where("uid", isEqualTo: uid)
        .limit(1);

    return userSnapshot.snapshots().map(
          (querySnap) => querySnap.docs
              .map((e) => UserEntity.fromModel(UserModel.fromJson(e.data())))
              .toList(),
        );
  }

  @override
  Future<bool> isSignedIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        Fluttertoast.showToast(
          msg: "Please enter a correct email or password",
        );
        return;
      } else if (e.code == "user-not-found") {
        Fluttertoast.showToast(
          msg: "User not found.",
        );
        return;
      } else if (user.email!.isEmpty || user.password!.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please fill all the credentials.",
        );
        return;
      } else {
        Fluttertoast.showToast(
          msg: e.toString(),
        );
        return;
      }
      // return;
    }
  }

  @override
  Future<void> logout() async => await firebaseAuth.signOut();

  @override
  Future<UserEntity> rgisterUser(UserEntity user) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      if (userCredential.user != null) {
        await uploadData(user);

        return UserEntity(
          uid: userCredential.user!.uid,
          email: user.email,
          password: user.password,
          username: user.username,
        );
      }

      throw Exception("Registration failed!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "This email is already in use.");
        rethrow;
      } else {
        Fluttertoast.showToast(msg: "$e.");
        rethrow;
      }
    }
  }
}
