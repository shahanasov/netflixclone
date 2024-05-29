import 'dart:convert';

import 'package:netflix/models/movie.dart';
import 'package:http/http.dart' as http;

class Api{
  static const _trendingMovies='https://api.themoviedb.org/3/movie/popular?api_key=bbc436cbd5ee0318f92b779a8b540f39';

 Future<List<Movie>> gettrendingMovies()async{
  final response = await http.get(Uri.parse(_trendingMovies));
  //200 means if everything is fine 
  if(response.statusCode==200){
    final decoded=json.decode(response.body)['results'] as List;
    // print(decoded);
    return decoded.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception('error');
  }

  }
}