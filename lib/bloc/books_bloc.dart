import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:palm_code_books/db/database_helper.dart';
import 'package:palm_code_books/models/book_model.dart';
import 'package:palm_code_books/models/detail_book_model.dart';
import 'package:palm_code_books/repository/books_repository.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {

    on<BooksEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is GetAllBooks) {
        emit(BooksLoading());
        try {
          final booksModel =
              await BooksRepository().getBooks(url: event.nextUrl);
          emit(GetBooksSuccess(booksModel));
        } catch (e) { 
          emit(BooksFailed(e.toString()));
        }
      }

      if (event is GetAllBooksFavorite) {
        try {
          final books = await DatabaseHelper().getBooks();
          emit(GetBooksFavoriteSuccess(books));
        } catch (e) {
          print(e.toString());
          emit(BooksFailed(e.toString()));
        }
      }

      if (event is GetDetailBooks) {
        emit(BooksLoading());
        try {
          final detailBook =
              await BooksRepository().getBooksDetail(event.booksId);
          final books = await DatabaseHelper().getBookById(detailBook.id);
          emit(GetBooksDetailSuccess(detailBook, books.isNotEmpty));
        } catch (e) {
          emit(BooksFailed(e.toString()));
        }
      }

      if (event is AddFavoriteBooks) {
        try {
          await DatabaseHelper().insertBook(event.result!);
          final currentState = state as GetBooksDetailSuccess;
          emit(GetBooksDetailSuccess(currentState.detailBooksModel, true));
        } catch (e) {
          print(e.toString());
          emit(BooksFailed(e.toString()));
        }
      }

      if (event is RemoveFavoriteBooks) {
        try {
          final books = await DatabaseHelper().removeBook(event.result!);
          final currentState = state as GetBooksDetailSuccess;
          emit(GetBooksDetailSuccess(currentState.detailBooksModel, false));
        } catch (e) {
          emit(BooksFailed(e.toString()));
        }
      }
    });
  }
}
