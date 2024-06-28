import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/UI/views/holder_view.dart';
import 'package:palm_code_books/UI/views/list_book_view.dart';
import 'package:palm_code_books/bloc/books_bloc.dart';
import 'package:palm_code_books/common/theme.dart';
import 'package:palm_code_books/models/book_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BooksBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: lightBackgroundColor,
            iconTheme: IconThemeData(color: blackColor),
            appBarTheme: AppBarTheme(
              backgroundColor: secondaryBlackColor,
              elevation: 0,
              iconTheme: IconThemeData(color: whiteColor),
            ),
            useMaterial3: true,
          ),
          initialRoute: HolderView.routeName,
          routes: {
            HolderView.routeName: (context) => HolderView(),
            ListBookView.routeName: (context) => ListBookView(),
            DetailBookView.routeName: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              return DetailBookView(
                booksId: args['booksId'] as int?,
                resultBook: args['resultBook'] as Result?,
              );
            },
          },
        ));
  }
}
