import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';

class PersonDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
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
            Text(
              loadedPerson.dayLost  ,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
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
            )
          ],
        ),
      ),
    );
  }
}
