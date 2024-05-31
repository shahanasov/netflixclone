import 'package:flutter/material.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/screen/details.dart';
import 'package:netflix/widgets/search.dart';
import 'package:netflix/services/api.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  const SearchResultPage({super.key, required this.query});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late String quary;
  //  late Future<List<Movie>> searchResult;

  final TextEditingController searchController = TextEditingController();
  List<Movie> searchResult = [];

  void _searchMovies() async {
    final query = searchController.text;
    if (query.isNotEmpty) {
      final results = await Api().searchMovies(query);
      setState(() {
        searchResult = results;
      });
    }
  }

  @override
  void initState() {
    quary = widget.query;
    // searchResult= Api().searchMovies(quary);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 500),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Search', prefixIcon: Icon(Icons.search)),
                  controller: searchController,
                  onChanged: (value) {
                    _searchMovies();
                  },
                ),
              )),
          body: searchResult.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      itemCount: searchResult.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 9 / 16,
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                            movie: searchResult[index])));
                              },
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${searchResult[index].posterPath}'),
                            ),
                            Text(
                              searchResult[index].title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      }))
              : const SearchPage()),
    );
  }
}
