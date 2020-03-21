import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Posts with ChangeNotifier {
  List<Post> _items = [];

     final String authToken;
  final String userId;
  Posts(this.authToken,this.userId,this._items);
  List<Post> get items {

    return [..._items];
  }

  List<Post> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Post findById(String id) {
    return _items.firstWhere((post) => post.id == id);
  }



  Future<void> fetchAndSetPerson([bool filterByUser=false]) async {
    final filterString=filterByUser?'orderBy="creatorId"equalTo="$userId"':'';
   var url = 'https://lost-of-people-4abff.firebaseio.com/persons.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData==null){
        return;
      }
       url = 'https://lost-of-people-4abff.firebaseio.com/userFavorites/$userId.json?auth=$authToken';

      final favoritrResponse= await http.get(url);
      final favaiteData =json.decode(favoritrResponse.body);
      final List<Post> lodedProducts = [];
      extractedData.forEach((postId, postData) {
        lodedProducts.add(Post(
            id: postId,

          name: postData['name'],
          dayLost: postData['dayLost'],
          description: postData['description'],
          location: postData['location'],
          imageUrl: postData['imageUrl'],
          isFavorite:favaiteData==null?false:  favaiteData[postId] ??false,

        ));
      });
      _items = lodedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPerson(Post post) async {
    final url = 'https://lost-of-people-4abff.firebaseio.com/persons.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'name': post.name,
            'description': post.description,
            'imageUrl': post.imageUrl,
            'dayLost': post.dayLost,
            'creatorId':userId,
            'location':post.location,

          }));
      final newperson = Post(
        name: post.name,
        description: post.description,
        imageUrl: post.imageUrl,
        dayLost: post.dayLost,
        location: post.location,
        id: json.decode(response.body)['name'],
      );

      _items.add(newperson);
//   items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updatePerson(String id, Post newPost) async {
    final prodIndex = _items.indexWhere((post) => post.id == id);
    if (prodIndex >= 0) {
      final url = 'https://lost-of-people-4abff.firebaseio.com/persons/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'name': newPost.name,
            'location':newPost.location,
            'description': newPost.description,
            'imageUrl': newPost.imageUrl,
            'dayLost': newPost.dayLost,
          }));
      _items[prodIndex] = newPost;
      notifyListeners();
    } else {
      print("...");
    }
  }

Future<void> deletePerson(String id) async{
    final url = 'https://lost-of-people-4abff.firebaseio.com/persons/$id.json?auth=$authToken';
    final existingpostIndex=_items.indexWhere((post)=>post.id==id);
    var existingProduct=_items[existingpostIndex];
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    _items.removeAt(existingpostIndex);
  final response= await  http.delete(url) ;
      if(response.statusCode>=400){
        throw HttpException('could not delete person.');
      }
      existingProduct=null;

    {
      _items.insert(existingpostIndex, existingProduct);
      notifyListeners();

  }
}



}
