import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services/users.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'webviewer.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'example.dart';

enum Status { Updating, Fetched, Error }

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
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
      home: UsersList(),
    );
  }
}

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Status status = Status.Updating;

  List<UserModel> myUsers;
  String picUrl;
  String userName;
  String profileLink;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    var updater = await UserModel.getUsers();
    setState(() {
      if (updater == null)
        status = Status.Error;
      else
        status = Status.Fetched;
      myUsers = updater;
    });
    print(updater);
//    return updater;
  }

  _retry() async {
    setState(() {
      status = Status.Updating;
    });
    _fetchUsers();
  }

//  _launchURL(url) async {
////    const url = 'https://flutter.dev';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  Widget _buildUserList() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
//              shrinkWrap: true,
              itemCount: myUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      myUsers[index].picUrl,
                    ),
                  ),
                  title: Text(
                    myUsers[index].userName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('user location'),
                  trailing: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
//                      _launchURL(myUsers[index].profileLink);
                      profileLink = myUsers[index].profileLink;
                      userName = myUsers[index].userName;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebViewer(
                          url: profileLink,
                          userName: userName,
                        );
                      }));
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
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "View Profile",
                              style: TextStyle(fontSize: 10.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              FontAwesomeIcons.github,
                              size: 15.0,
                            ),
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

  Widget _buildUpdating() {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.purple,
          size: 70.0,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Column(
//          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'An Error occurred',
              style: TextStyle(color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.refresh, size: 50.0, color: Colors.teal,),
                    onPressed: () {
                      _retry();
                    }),
                SizedBox(width: 20,),
                Text('retry'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _determineChild() {
    if (status == Status.Updating) {
      return _buildUpdating();
    } else if (status == Status.Fetched) {
      return _buildUserList();
    } else {
      return _buildError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Github Users',
          style: TextStyle(fontFamily: 'nunito'),
        ),
        backgroundColor: Color(0xFF2F3035),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _retry();
              })
        ],
      ),
      body: _determineChild(),
    );
  }
}
