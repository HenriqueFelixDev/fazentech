import 'package:fazentech/app/exceptions/authentication_exception.dart';
import 'package:fazentech/app/exceptions/default_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository_interface.dart';
import '../../models/user/user_model.dart';

class AuthRepositoryFirebase implements IAuthRepository {
  AuthRepositoryFirebase();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> getAuthenticationToken() {
    return _firebaseAuth?.currentUser?.getIdToken();
  }

  @override
  Future<Map<String, String>> signInWithEmailAndPassword(String email, String password) async{
    try {
      String token = await getAuthenticationToken();
      String refreshToken = _firebaseAuth?.currentUser?.refreshToken;
    
      if(token == null && refreshToken == null) {
        final userCredential = 
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      
        token = await userCredential.user.getIdToken();
        refreshToken = userCredential.user.refreshToken;
      }

      return {
        'token': token,
        'refreshToken': refreshToken
      };
    } on FirebaseAuthException catch(e) {
      String message;
      switch(e.code) {
        case 'invalid-email':
        case 'wrong-password':
          message = 'E-mail e/ou senha incorretos';
          break;
        case 'user-disabled':
        case 'user-not-found':
          message = 'Usuário não existe';
          break;
        default:
          message = 'Falha ao realizar o login';
      }

      throw AuthenticationException(message);
    }
  }

  @override
  Future<void> signOut() async => _firebaseAuth.signOut();

  @override
  Future<void> signUpWithEmailAndPassword(UserModel user) async{
    await _firebaseAuth
      .createUserWithEmailAndPassword( email: user.email, password: user.password);
  }

}