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
            title: Text('مرحبا بالأصدقاء'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home,color: Colors.blue,),
            title: Text('Lost Of People',style: TextStyle(color: Colors.blue,),),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search,color: Colors.green,),
            title: Text('ابحث علي الخريطه',style: TextStyle(color: Colors.green,),),
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
//                MaterialPageRoute(builder: (context) => MapSample()),
//              );
//            },
          //  ),

          Divider(),
          ListTile(
            leading: Icon(Icons.edit,color: Colors.green,),
            title: Text('اضافة أوالتعديل علي شخص', style: TextStyle(color: Colors.green,),),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserPersonScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications,color: Colors.blue,),
            title: Text('الاعدادات', style: TextStyle(color: Colors.blue,),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => seteing_screen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            title: Text('تسجيل الخروج',style: TextStyle(color: Colors.red,),),
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
