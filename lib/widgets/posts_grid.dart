import 'package:flutter/material.dart';
import '../widgets/post_item.dart';

import 'package:provider/provider.dart';
import '../providers/posts.dart';


class PersonsGrid extends StatelessWidget {
 final bool showFavs;
 PersonsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<Posts>(context);
    final posts = showFavs?postsData.favoriteItems :  postsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),

      itemCount: posts.length,
     itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //builder: (c)=> products[i],
       value: posts[i],
     child: PostItem(
            // products[i].id,
          // products[i].title,
       //  products[i].imageUrl,
     )
     ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10.0),
  );

  }
}
