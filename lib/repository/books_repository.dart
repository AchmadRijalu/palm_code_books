import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:palm_code_books/UI/views/detail_book_view.dart';
import 'package:palm_code_books/models/book_model.dart';
import 'package:palm_code_books/models/detail_book_model.dart';

class BooksRepository {
  static const String _url = "https://gutendex.com/books/";

  Future<BooksModel> getBooks({String? url}) async {
    try {
      final response = await http.get(Uri.parse(url ?? _url));
      if (response.statusCode == 200) {
        return BooksModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {

      throw Exception('Failed to load data: $e');
    }
  }

  Future<DetailBooksModel> getBooksDetail(int? id) async {
    try {
      final response = await http.get(
        Uri.parse("${_url}$id"),
      );
      return DetailBooksModel.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
