import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
          final books = await BooksRepository().getBooks();
          emit(GetBooksSuccess(books));
        } catch (e) {
          emit(BooksFailed(e.toString()));
        }
      }

      if (event is GetDetailBooks) {
        emit(BooksLoading());
        try {
          final detailBook =
              await BooksRepository().getBooksDetail(event.booksId);
          emit(GetBooksDetailSuccess(detailBook));
        } catch (e) {
          emit(BooksFailed(e.toString()));
        }
      }
    });
  }
}
