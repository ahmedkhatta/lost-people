import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../Screens/edit_post_screen.dart';
class UserProductItem extends StatelessWidget {
  final String id ;
  final String name;
  final String imageUrl;

  UserProductItem(this.id,this.name, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold =    Scaffold.of(context);
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
              Navigator.of(context).pushNamed(EditPersonScreen.routeName,arguments:id );
                }),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor,
                onPressed: () async{
                  try{
                    Provider.of<Posts>(context,listen: false).deletePerson(id);

                  }catch(error){
                    scaffold.showSnackBar(SnackBar
                      (content: Text('Deleting failed',textAlign: TextAlign.center,)


                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
