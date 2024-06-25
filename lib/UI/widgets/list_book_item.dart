import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:palm_code_books/models/book_model.dart';

import '../../common/theme.dart';

class ListBookItem extends StatelessWidget {
  final Result? bookResult;
  void Function()? onTap;
  ListBookItem({Key? key, this.bookResult, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          height: 104,
          child: Row(
            children: [
              Flexible(
                  child: Container(
                child: FancyShimmerImage(
                  width: 100,
                  height: 150,
                  boxFit: BoxFit.contain,
                  imageUrl: "${bookResult?.formats.imageJpeg}",
                ),
              )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              width: double.infinity,
                              child: Text(bookResult?.title ?? "Books Title",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2),
                            )),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.topLeft,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: bookResult?.authors.length,
                              itemBuilder: (BuildContext context, int index) {
                                var author = bookResult?.authors[index];
                                return Text(author?.name ?? "Author Name");
                              }),
                        ))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }

  //   Card(
  //       child: ListTile(
  //     leading: Image.network(
  //       "${bookResult?.formats.imageJpeg}",
  //       fit: BoxFit.fitWidth,
  //     ),
  //     title: Text(bookResult?.title ?? "Books Title"),
  //     subtitle: SizedBox(
  //         height: 50,
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: ListView.builder(
  //                   shrinkWrap: true,
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount: bookResult?.authors.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     var author = bookResult?.authors[index];
  //                     return Text(author?.name ?? "Author Name");
  //                   }),
  //             ),
  //           ],
  //         )),
  //     trailing: FittedBox(
  //       fit: BoxFit.fill,
  //       child: Row(
  //         children: <Widget>[
  //           Icon(
  //             Icons.star_rate,
  //             color: Colors.orange,
  //           ),
  //           Text("rating")
  //         ],
  //       ),
  //     ),
  //   ));
  // }
}
