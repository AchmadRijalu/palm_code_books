import 'package:flutter/material.dart';
import 'package:palm_code_books/UI/views/favorite_book_view.dart';
import 'package:palm_code_books/UI/views/list_book_view.dart';
import 'package:palm_code_books/common/theme.dart';

class HolderView extends StatefulWidget {
  static const routeName = "/";
  HolderView({super.key});

  @override
  State<HolderView> createState() => _HolderViewState();
}

class _HolderViewState extends State<HolderView> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavbarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.book),
        activeIcon: Icon(
          Icons.book,
          color: secondaryBlackColor,
        ),
        label: "Books"),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        activeIcon: Icon(
          Icons.favorite,
          color: secondaryBlackColor,
        ),
        label: "Favorite"),
  ];

  List<Widget> listWidget = [ListBookView(), FavoriteBookView()];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        useLegacyColorScheme: true,
        selectedItemColor: secondaryBlackColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomNavbarItems,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (selected) {
          setState(() {
            currentIndex = selected;
          });
        },
      ),
    );
  }
}
