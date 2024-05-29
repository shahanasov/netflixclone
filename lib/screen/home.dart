import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/services/api.dart';
import 'package:netflix/widgets/scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingMovies = Api().gettrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Netflix'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Trending Movies'),
              ),
              SizedBox(
                // width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: 20,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    height: 250,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  itemBuilder: (context, index, indexpage) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 190,
                        color: Colors.cyan,
                        child: FutureBuilder(
                          future: trendingMovies,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.hasData) {
                              // final data=snapshot.data;
                              return SizedBox(
                                height: 200,
                                width: 150,
                                child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}'),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Top rated Movies'),
              ),
              FutureBuilder(
                future: trendingMovies,
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
                    return SizedBox();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Upcoming Movies'),
              ),
            ],
          ),
        ));
  }
}
