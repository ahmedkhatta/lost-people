import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Screens/post_details_screen.dart';
import '../providers/auth.dart';

import '../providers/post.dart';
import 'package:share/share.dart';

class PostItem extends StatelessWidget {
//  final String id;
  // final String title;
  // final String imageUrl;
//  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Post>(context, listen: false);

    final authData = Provider.of<Auth>(context, listen: false);
    return Container(
      width: double.infinity,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),

        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  PersonDetailsScreen.routeName,
                  arguments: product.id,
                );
              },
              child: Hero(
                tag: product.id,
                child: Container(
                  child: FadeInImage(
                    placeholder:
                        AssetImage('assets/images/_product-placeholder.jpg'),
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          footer: GridTileBar(
            backgroundColor: Colors. blueGrey.shade100,
            leading: Consumer<Post>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStatus(
                    authData.token,
                    authData.userId,
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.name,
              style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            trailing: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {

                    Share.share('share post');

                  },
                  color: Theme.of(context).accentColor,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
