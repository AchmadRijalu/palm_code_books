import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/UI/widgets/list_book_item.dart';
import 'package:palm_code_books/bloc/books_bloc.dart';
import 'package:palm_code_books/common/theme.dart';
import 'package:palm_code_books/models/book_model.dart';

class FavoriteBookView extends StatefulWidget {
  const FavoriteBookView({Key? key}) : super(key: key);

  @override
  _FavoriteBookViewState createState() => _FavoriteBookViewState();
}

class _FavoriteBookViewState extends State<FavoriteBookView> {
  String searchTitle = '';
  var _bloc = BooksBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc..add(GetAllBooksFavorite()),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Favorites",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CupertinoSearchTextField(
                      placeholder: "Search Favorite Book",
                      onChanged: (value) {
                        setState(() {
                          searchTitle = value.toLowerCase();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<BooksBloc, BooksState>(
                  builder: (context, state) {
                    if (state is GetBooksFavoriteSuccess) {
                      final filteredList = state.bookResult!
                            .where(
                              (book) => book.title!
                                  .toLowerCase()
                                  .contains(searchTitle),
                            )
                            .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          var bookResult = state.bookResult![index];
                          return ListBookItem(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                DetailBookView.routeName,
                                arguments: {
                                  'booksId': filteredList[index].id,
                                  'resultBook': filteredList[index],
                                },
                              );
                              _bloc.add(GetAllBooksFavorite());
                            },
                            bookResult: filteredList[index],
                          );
                        },
                      );
                    } else if (state is BooksFailed) {
                      return Center(
                        child: Text(state.e!),
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
