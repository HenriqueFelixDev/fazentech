import 'package:http/http.dart' as http;
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:convert';

import 'user_repository_interface.dart';
import '../auth/auth_repository_interface.dart';
import '../../models/user/user_model.dart';

class UserRepositoryAPI implements IUserRepository {
  final _authRepository = Modular.get<IAuthRepository>(); 
  static const BASE_URL = 'http://10.0.0.106';

  @override
  Future<UserModel> getUserById(String id) async{
      final token = await _authRepository.getAuthenticationToken();
      if(token == null) return null;

      final response = await http.get('$BASE_URL/user', headers: {'Authorization': 'Bearer $token'});
      if(response.statusCode >= 200 && response.statusCode < 300) {
        final userMap = json.decode(response.body);
        return UserModel.fromMap(userMap);
      }
      return null;
    }
  
    @override
    Future<void> saveUser(UserModel user) async{
      final response = await http.post(
        '$BASE_URL/user',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toMap())
      );
      if(response.statusCode >= 300) {
        throw new Exception('Falha ao cadastrar o usuário');
      }
    }
  
    @override
    Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}