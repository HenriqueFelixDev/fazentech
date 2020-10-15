import 'package:fazentech/app/shared/models/user/user_model.dart';
import 'package:fazentech/app/shared/repositories/auth/auth_repository_interface.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_firebase.dart';
import 'package:fazentech/app/shared/repositories/user/user_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryFirebase implements IAuthRepository {
  IUserRepository userRepository;
  FirebaseAuth _firebaseAuth;
  AuthRepositoryFirebase(this.userRepository) {
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<UserModel> getSignedUser() async{
    final user = _firebaseAuth.currentUser;
    if(user == null) return Future.value(null);

    final userModel = await userRepository.getUserById(user.uid);
    userModel.photo = user.photoURL;
    return userModel;
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async{
    final signedUser = await getSignedUser();
    if(signedUser != null) return signedUser;

    final userCredential = 
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final userId = userCredential.user.uid;
    
    final user = await userRepository.getUserById(userId);
    user.photo = userCredential.user.photoURL;
    
    return user;
  }

  @override
  Future<void> signOut() async => _firebaseAuth.signOut();

  @override
  Future<UserModel> signUpWithEmailAndPassword(UserModel user) async{
    final userCredential = 
      await _firebaseAuth
        .createUserWithEmailAndPassword( email: user.email, password: user.password);
    user.id = userCredential.user.uid;
    user.photo = userCredential.user.photoURL;

    await userRepository.saveUser(user);
    return user;
  }

  Future<void> updateAccount(UserModel user) async{
    await _firebaseAuth.currentUser.updateProfile(photoURL: user.photo);
    await userRepository.updateUser(user);
  }

}