import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_project/data/endpoint/endpoint.dart';
import 'package:new_project/domain/model/user_model.dart';
import 'package:new_project/domain/repository/auth_repository.dart';
import 'package:new_project/feature/views/home/home.dart';
import 'package:new_project/utils/helper/pref_helper.dart';

bool firstInit = true;
class AuthController implements AuthRepository {
  @override
  Future<bool> login(String username, String password, BuildContext context)  async{
    if (firstInit){
         PrefHelper.instance.init();
         firstInit = false;
    }
    try{
      Response response = await post(
          Uri.parse(Endpoint.login),
          body: {
            'username' : username,
            'password' : password
          }
      );
      if(response.statusCode == 200){
        var data = await jsonDecode(response.body.toString());
        UserLogin.id = int.parse(data['id']);
        UserLogin.name = data['nama'];
        UserLogin.roles = data['roles'];
        UserLogin.email = data['email'];
        await PrefHelper.instance.saveToken(data['token'] ?? "");
        return true;
      }else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  @override
  Future<void> logout() async {
    UserLogin.id = null;
    UserLogin.name = null;
    UserLogin.roles = null;
    UserLogin.email = null;
    await PrefHelper.instance.saveToken("");
  }
}
