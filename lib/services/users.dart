import 'network.dart';

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
//      userData = data;
      userData = List.from(data).map((x)=>UserModel.fromJson(Map<String,dynamic>.from(x))).toList();
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