import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../widgets/app_drawer.dart';
import '../widgets/posts_grid.dart';
enum FilterOptions {
  Favorites,
  All,
}class PersonOverViewScreen extends StatefulWidget {
  @override
  _PersonsOverViewScreenState createState() => _PersonsOverViewScreenState();
}
class _PersonsOverViewScreenState extends State<PersonOverViewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoding = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoding = true;
      });
      Provider.of<Posts>(context).fetchAndSetPerson().then((_) {
        _isLoding = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lost Of People"), actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectValue) {
            setState(() {
              if (selectValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("الأشخاص المفضله "),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text("رؤية كل الاشخاص"),
              value: FilterOptions.All,
            )
          ],
        ),
      ]),
      drawer: AppDrawer(),
      body: _isLoding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PersonsGrid(_showOnlyFavorites),
    );
  }
}
