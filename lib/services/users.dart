import 'network.dart';

class UserModel {

  Future<dynamic> getUsers() async {
      NetworkHelper networkHelper = NetworkHelper(url: 'https://api.github.com/users?language=flutter');

      var userData = await networkHelper.getData();
      print(userData);
      return userData;
  }
}