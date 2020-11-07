import 'package:fazentech/app/exceptions/invalid_parameters_exception.dart';
import 'package:fazentech/app/shared/models/parameter_error_model.dart';
import 'package:fazentech/app/shared/services/http/http_client_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:convert';

import 'user_repository_interface.dart';
import '../auth/auth_repository_interface.dart';
import '../../models/user/user_model.dart';

class UserRepositoryAPI implements IUserRepository {
  final _authRepository = Modular.get<IAuthRepository>();
  final httpClient = Modular.get<IHttpClient>();

  @override
  Future<UserModel> getUserById(String id) async{
      final token = await _authRepository.getAuthenticationToken();
      if(token == null) return null;

      final userMap = await httpClient.get(
        '/user', 
        headers: {'Authorization': 'Bearer $token'}
      );

      if(userMap != null) {
        return UserModel.fromMap(userMap);
      }

      return null;
    }
  
    @override
    Future<void> saveUser(UserModel user) async{
      await httpClient.post(
        '/user',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toMap()),
        onError: (code, body) {
          if(code == 400) {
            final error = json.decode(body)['error'];
            throw InvalidParametersException(
              'Alguns campos estão com valores incorretos',
              error['errors'].map<ParameterErrorModel>(
                (errorMap) => ParameterErrorModel.fromMap(errorMap)
              ).toList()
            );
          }
        }
      );
    }
  
    @override
    Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}