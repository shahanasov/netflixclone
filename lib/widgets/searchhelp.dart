import 'package:flutter/material.dart';
import 'package:netflix/widgets/search.dart';
import 'package:netflix/screen/searchresult.dart';

class SearchingDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton.outlined(onPressed: (){
        query='';
      }, icon: const Icon(Icons.clear))
    ];
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton.outlined(onPressed: (){}, icon: const Icon(Icons.search));
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
   return const SearchPage();
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchResultPage(query: query,);
    // throw UnimplementedError();
  }

}