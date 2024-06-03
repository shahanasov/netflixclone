import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/screen/details.dart';
import 'package:netflix/services/api.dart';
import 'package:netflix/widgets/scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRated;
  late Future<List<Movie>> upcoming;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().gettrendingMovies();
    topRated = Api().gettopMovies();
    upcoming = Api().getupcoming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'GoTV',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 79, 31, 47),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text('Home')),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Text('Trending Movies'),
              SizedBox(
                width: double.maxFinite,
                child: CarouselSlider.builder(
                  itemCount: 20,
                  options: CarouselOptions(
                    padEnds: false,
                    aspectRatio: 9 / 16,
                    enlargeCenterPage: false,
                    pageSnapping: true,
                    height: 450,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  itemBuilder: (context, index, indexpage) {
                    return
                      
                        Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: FutureBuilder(
                        future: trendingMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            // final data=snapshot.data;
                            return Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  movie:
                                                      snapshot.data![index])));
                                    },
                                    child: SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Image.network(
                                          colorBlendMode: BlendMode.darken,
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                          'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}'),
                                    ),
                                  ),

                                  // const SizedBox(
                                  //   height: 200,
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     snapshot.data![index].title,
                                  //     style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                ]);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    );
                    // )
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Top rated Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    // final data=snapshot.data;
                    return 
                        ScrollItems(
                          snapshot: snapshot,
                        );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Upcoming Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder(
                future: upcoming,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    // final data=snapshot.data;
                    return ScrollItems(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
