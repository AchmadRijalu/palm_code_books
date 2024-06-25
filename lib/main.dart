import 'package:flutter/material.dart';
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/UI/views/holder_view.dart';
import 'package:palm_code_books/UI/views/list_book_view.dart';
import 'package:palm_code_books/common/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        iconTheme: IconThemeData(color: blackColor),
        appBarTheme: AppBarTheme(
          backgroundColor: secondaryBlackColor,
          elevation: 0,
          iconTheme:  IconThemeData(color: whiteColor),
        ),
        useMaterial3: true,
      ),
      initialRoute: HolderView.routeName,
      routes: {
        HolderView.routeName: (context) => HolderView(),
        ListBookView.routeName: (context) => ListBookView(),
        DetailBookView.routeName: (context) => DetailBookView(
              booksId: ModalRoute.of(context)!.settings.arguments as int,
            ),
      },
    );
  }
}
