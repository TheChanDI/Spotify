import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signIn(SigninUserReq signinUserReq);
  Future<Either> signUp(CreateUserReq createUserreq);
  Future<void> signOut();
}

class AuthFirebaseServiceImplementation implements AuthFirebaseService {
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return const Right("Signin was Successfull.");
    } on FirebaseAuthException catch (err) {
      String msg = '';
      if (err.code == 'invalid-email') {
        msg = 'Email is invalid.';
      } else if (err.code == 'user-not-found') {
        msg = 'User not found.';
      } else if (err.code == 'wrong-password') {
        msg = 'Password is incorrect.';
      }
      return Left(msg);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserreq) async {
    try {
      var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserreq.email,
        password: createUserreq.password,
      );

      final user = cred.user;
      if (user == null) {
        return const Left("Signup failed: user is null.");
      }

      // Optional: set display name (so FirebaseAuth user has it too)
      await user.updateDisplayName(createUserreq.fullName);
      await user.reload();

      await FirebaseFirestore.instance.collection('users').add({
        'uid': user.uid,
        'name': createUserreq.fullName,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return const Right("Signup was Successfull.");
    } on FirebaseAuthException catch (err) {
      String msg = '';
      if (err.code == 'email-already-in-use') {
        msg = 'Email already in use with that email.';
      } else if (err.code == 'weak-password') {
        msg = 'Password should be at least 6 characters.';
      } else if (err.code == 'invalid-email') {
        msg = 'Invalid email.';
      }
      return Left(msg);
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
