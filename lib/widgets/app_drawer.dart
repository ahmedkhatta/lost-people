import 'package:flutter/material.dart';

import '../Screens/seting%20screen.dart';


import '../FORM_INPUTS/location.dart';


import '../providers/auth.dart';
import '../Screens/user_posts_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend !'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Lost Of People'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search by Location'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => location_personHome()),
              );
            },

          ),
//          Divider(),
//          ListTile(
//            leading: Icon(Icons.person),
//            title: Text('search'),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => search()),
//              );
//            },
//          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Seting'),

    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => seteing_screen()),
    );
    },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage data person'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserPersonScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              //   Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
