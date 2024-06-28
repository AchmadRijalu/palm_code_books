import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/UI/widgets/list_book_item.dart';
import 'package:palm_code_books/bloc/books_bloc.dart';
import 'package:palm_code_books/common/theme.dart';

class ListBookView extends StatefulWidget {
  static const routeName = '/list-book';
  const ListBookView({super.key});

  @override
  State<ListBookView> createState() => _ListBookViewState();
}

class _ListBookViewState extends State<ListBookView> {
  TextEditingController searchController = TextEditingController(text: '');
  String filterText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        body: BlocProvider(
          create: (context) => BooksBloc()..add(GetAllBooks()),
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
                            "Books",
                            style: blackTextStyle.copyWith(
                                fontSize: 40, fontWeight: bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CupertinoSearchTextField(
                        placeholder: "Search Books",
                        onChanged: (value) {
                          setState(() {
                            filterText = value.toLowerCase();
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
                      if (state is BooksLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      } else if (state is GetBooksSuccess) {
                        final filteredList = state.booksModel!.results!
                            .where(
                              (book) => book.title!
                                  .toLowerCase()
                                  .contains(filterText),
                            )
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return ListBookItem(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailBookView.routeName,
                                  arguments: {
                                    'booksId': filteredList[index].id,
                                    'resultBook': filteredList[index]
                                  },
                                );
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
        ));
  }
}
