import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services/users.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Github Users',
          style: TextStyle(fontFamily: 'nunito'),
        ),
        backgroundColor: Color(0xFF2F3035),
      ),
      body: UsersList(),
    );
  }
}

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
    userModel.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://avatars1.githubusercontent.com/u/36922198?s=460&u=2f6c001435568e44b18fc5f657062532dcf92758&v=4'),
                  ),
                  title: Text(
                    'name of user',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'nunito', fontWeight: FontWeight.bold,),
                  ),
                  subtitle: Text('user location'),
                  trailing: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      userModel.getUsers();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 5.0, bottom: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("View Profile", style: TextStyle(fontSize: 10.0),),
                            SizedBox(width: 5.0,),
                            Icon(FontAwesomeIcons.github, size: 15.0,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 20.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
