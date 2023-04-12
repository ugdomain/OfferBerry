import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AuctionScreen extends StatelessWidget {
  AuctionScreen({super.key});

  final List<String> listImages = [
    "https://images.unsplash.com/photo-1572537165377-627a37043464?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGl4ZWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1572204292164-b35ba943fca7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cGl4ZWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1590254553792-7e91903c5357?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHBpeGVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1548586196-aa5803b77379?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHBpeGVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1572447454458-e68d82f828b3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODd8fHBpeGVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1572204304559-b5f5380482c5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTA4fHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1554516829-a3fce6ddbc6e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTQzfHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1563642421748-5047b6585a4a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTY2fHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1593439147804-c6c7656530ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzUzfHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: true
          ? Placeholder()
          : SafeArea(
              child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: MasonryGridView.builder(
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: listImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Image.network(
                              listImages[index],
                              // width: MediaQuery.of(context).size.width / 2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    //  MasonryGridView.count(
                    //   mainAxisSpacing: 10,
                    //   crossAxisSpacing: 8,
                    //   crossAxisCount: 2,
                    //   itemCount: listImages.length,
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(12)),
                    //         color: Colors.transparent,
                    //       ),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.all(Radius.circular(12)),
                    //         child: Image.network(
                    //           listImages[index],
                    //           // width: MediaQuery.of(context).size.width / 2,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ],
            )

              // GridView.builder(
              //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              //     // mainAxisSpacing: 10.0,
              //     // crossAxisSpacing: 10.0,
              //     // childAspectRatio: 4.0,
              //   ),
              //   itemBuilder: (context, index) {
              //     final int width = math.Random().nextInt(200) + 100;
              //     final int height = math.Random().nextInt(200) + 100;
              //     return Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Colors.grey,
              //         ),
              //       ),
              //       child: Image.network(
              //         "https://picsum.photos/${width}/${height}",
              //         height: height.toDouble(),
              //         fit: BoxFit.cover,
              //       ),
              //     );
              //   },
              //   itemCount: 10,
              // ),
              ),
    );
  }
}
