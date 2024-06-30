import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/UI/widgets/list_book_item.dart';
import 'package:palm_code_books/bloc/books_bloc.dart';
import 'package:palm_code_books/common/theme.dart';
import 'package:palm_code_books/models/book_model.dart';

class ListBookView extends StatefulWidget {
  static const routeName = '/list-book';
  const ListBookView({super.key});

  @override
  State<ListBookView> createState() => _ListBookViewState();
}

class _ListBookViewState extends State<ListBookView> {
  final BooksBloc _bloc = BooksBloc();
  final ScrollController _scrollController = ScrollController();
  bool canLoadMore = true;
  int currentPage = 1;
  List<Result> books = [];
  String searchTitle = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          canLoadMore &&
          searchTitle.isEmpty) {
        currentPage++;
        _bloc.add(GetAllBooks(
            nextUrl: 'https://gutendex.com/books/?page=$currentPage'));
        canLoadMore = false;
      }
    });
    _bloc.add(GetAllBooks());
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          canLoadMore &&
          searchTitle.isEmpty) {
        currentPage++;
        _bloc.add(GetAllBooks(
            nextUrl: 'https://gutendex.com/books/?page=$currentPage'));
        canLoadMore = false;
      }
    });
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: BlocProvider(
        create: (context) => _bloc,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    Text(
                      "Books",
                      style: blackTextStyle.copyWith(
                          fontSize: 40, fontWeight: bold),
                    ),
                    const SizedBox(height: 24),
                    CupertinoSearchTextField(
                      placeholder: "Search Books",
                      onChanged: (value) {
                        setState(() {
                          searchTitle = value.toLowerCase();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<BooksBloc, BooksState>(
                  listener: (context, state) {
                    if (state is GetBooksSuccess) {
                      setState(() {
                        if (state.booksModel != null &&
                            state.booksModel!.results.isNotEmpty) {
                          canLoadMore = true;
                          if (currentPage == 1) {
                            books = state.booksModel!.results;
                          } else {
                            books.addAll(state.booksModel!.results);
                          }
                        } else {
                          canLoadMore = false;
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    final filteredList = books
                        .where(
                          (book) =>
                              book.title!.toLowerCase().contains(searchTitle),
                        )
                        .toList();
                    if (state is BooksLoading && books.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: secondaryBlackColor),
                      );
                    } else if (state is BooksFailed) {
                      return Center(
                        child: Text(state.e),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredList.length +
                          (canLoadMore && searchTitle.isEmpty ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= filteredList.length &&
                            canLoadMore &&
                            searchTitle.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: secondaryBlackColor),
                          );
                        }
                        return ListBookItem(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailBookView.routeName,
                              arguments: {
                                'booksId': filteredList[index].id,
                                'resultBook': filteredList[index],
                              },
                            );
                          },
                          bookResult: filteredList[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
