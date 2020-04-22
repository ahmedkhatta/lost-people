import'package:flutter/foundation.dart';
import './post.dart';
class GreatPlaces with ChangeNotifier{
  List <Post> _items =[];
  List<Post> get items{
    return[..._items];
  }
}