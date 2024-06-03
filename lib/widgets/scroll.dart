import 'package:flutter/material.dart';
import 'package:netflix/screen/details.dart';
import 'package:netflix/services/apikey.dart';

class ScrollItems extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const ScrollItems({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 150,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(movie: snapshot.data[index])));
                      },
                      child: SizedBox(
                        height: 200,
                        width: 150,
                        child: Image.network(
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            '${Keys.imagePath}${snapshot.data[index].posterPath}'),
                      ),
                    ),
                  ),
                  
                  Text(
                    snapshot.data[index].title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }),
    );
  }
}
