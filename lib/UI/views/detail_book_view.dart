import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_code_books/bloc/books_bloc.dart';
import 'package:palm_code_books/common/theme.dart';
import 'package:palm_code_books/models/book_model.dart';

class DetailBookView extends StatefulWidget {
  static const routeName = '/detail-book';
  final int? booksId;
  final Result? resultBook;
  const DetailBookView({super.key, this.booksId, this.resultBook});

  @override
  State<DetailBookView> createState() => _DetailBookViewState();
}

class _DetailBookViewState extends State<DetailBookView> {
  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context)..add(GetDetailBooks(widget.booksId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Detail",
          style: whiteTextStyle,
        ),
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetBooksDetailSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    color: secondaryBlackColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FancyShimmerImage(
                                width: 100,
                                height: 150,
                                boxFit: BoxFit.cover,
                                imageUrl:
                                    "${state.detailBooksModel?.formats.imageJpeg}",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Total Downloads",
                                textAlign: TextAlign.center,
                                style: greyTextStyle.copyWith(
                                    fontSize: 12, fontWeight: regular),
                              ),
                              Text(
                                "${state.detailBooksModel?.downloadCount.toString()}",
                                textAlign: TextAlign.center,
                                style: greyTextStyle.copyWith(
                                    fontSize: 12, fontWeight: bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.detailBooksModel?.title ?? "",
                                        style: whiteTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: whiteColor,
                                      radius: 20,
                                      child: state.isBookmarked
                                          ? IconButton(
                                              onPressed: () async{
                                                context.read<BooksBloc>().add(
                                                    RemoveFavoriteBooks(
                                                        widget.resultBook?.id));
},
                                              icon: Icon(Icons.favorite),
                                              color: Colors.red)
                                          : IconButton(
                                              onPressed: () async {
                                                context.read<BooksBloc>().add(
                                                      AddFavoriteBooks(
                                                          widget.resultBook),
                                                    );
                                              },
                                              icon: Icon(Icons.favorite),
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                Text(
                                  "Authors",
                                  style: greyTextStyle,
                                ),
                                Container(
                                  height: 32,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          alignment: Alignment.topLeft,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.detailBooksModel!
                                                .authors.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var author = state
                                                  .detailBooksModel!
                                                  .authors[index];
                                              return Text(
                                                author?.name ?? "Author Name",
                                                style: whiteTextStyle,
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Subjects",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: semiBold),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.detailBooksModel!.subjects.length,
                          itemBuilder: (BuildContext context, int index) {
                            var subject =
                                state.detailBooksModel?.subjects[index];
                            return Text(
                              subject ?? "Subject",
                              style: blackTextStyle,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
