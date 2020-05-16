import 'network.dart';
import 'dart:convert';

class UserModel {

   String picUrl;
   String userName;
   String profileLink;

  UserModel({this.picUrl, this.userName, this.profileLink});

  static Future<List<UserModel>> getUsers() async {
    List<UserModel> userData;
    try{
      NetworkHelper networkHelper = NetworkHelper(url: 'https://api.github.com/users?language=flutter');
      var data = await networkHelper.getData();
//      userData = List.from(json.decode(data)).map((x)=>UserModel.fromJson(Map<String,dynamic>.from(x))).toList();
//      userData = data.map((x)=>UserModel.fromJson(Map<String,dynamic>.from(x))).toList();
      userData = List.from(data).map((x)=>UserModel.fromJson(Map<String,dynamic>.from(x))).toList();
      print(userData.runtimeType);

    }catch(error) {

      print('$error');
    }

    return userData;

  }

   UserModel.fromJson(Map<String, dynamic> json) {
     userName = json['login'];
     picUrl = json['avatar_url'];
     profileLink = json['html_url'];
  }

}