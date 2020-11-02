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
  }

  @override
  Future<void> signOut() async => _firebaseAuth.signOut();

  @override
  Future<void> signUpWithEmailAndPassword(UserModel user) async{
    await _firebaseAuth
      .createUserWithEmailAndPassword( email: user.email, password: user.password);
  }

}