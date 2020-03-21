import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Post with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String location ;
  final String dayLost;
  final String imageUrl;
  bool isFavorite;

  Post({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.location,
    @required this.dayLost,
    @required this.imageUrl,
    this.isFavorite = false,
  });



  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://lost-of-people-4abff.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}

