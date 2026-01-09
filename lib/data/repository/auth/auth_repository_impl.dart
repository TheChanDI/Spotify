import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service.locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserreq) async {
    return await sl<AuthFirebaseService>().signUp(createUserreq);
  }

  @override
  Future<Either> signIn(SigninUserReq signinUserReq) {
    return sl<AuthFirebaseService>().signIn(signinUserReq);
  }
}
