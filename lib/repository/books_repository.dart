import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/models/book_model.dart';
import 'package:palm_code_books/models/detail_book_model.dart';

class BooksRepository {
  static const String _url = "https://gutendex.com/books/";

  Future<BooksModel> getBooks() async {
    try {
      final response = await http.get(
        Uri.parse(_url),
      );
      return BooksModel.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception("Failed to load the data");
    }
  }

  Future<DetailBooksModel> getBooksDetail(int? id) async {
    try {
      final response = await http.get(
        Uri.parse("${_url}$id"),
      );
      return DetailBooksModel.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception("Failed to load the data");
    }
  }
}
