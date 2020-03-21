import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../widgets/user_posts_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_post_screen.dart';

class UserPersonScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false)
        .fetchAndSetPerson(true);
  }

  @override
  Widget build(BuildContext context) {
   // final productsData = Provider.of<Products>(context);
    print("rebuilding.....");
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Person'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditPersonScreen.routeName);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Posts>(

                        builder:(ctx,productsData,_)=> Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: productsData.items.length,
                              itemBuilder: (_, i) => Column(children: [
                                UserProductItem(
                                  productsData.items[i].id,
                                  productsData.items[i].name,
                                  productsData.items[i].imageUrl,
                                ),
                                Divider(),
                              ]),
                            )),
                      ),
                    ),
        ));
  }
}
