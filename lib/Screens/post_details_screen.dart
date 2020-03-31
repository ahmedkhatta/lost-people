import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/posts.dart';

class PersonDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final personId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedPerson = Provider.of<Posts>(
      context,
      listen: false,
    ).findById(personId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedPerson.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedPerson.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Text(" Name : "),
                  Text(
                    loadedPerson.name,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Text(" يوم فقد الشخص   ",textDirection: TextDirection.rtl,),
                  Text(
                    loadedPerson.dayLost,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedPerson.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),

            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () async {
                await launch(loadedPerson.facebock);
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    const Text('Go To Facebook To This Person',
                        style: TextStyle(fontSize: 20)),
                    Image.asset(
                      "assets/images/facebook.png",
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
