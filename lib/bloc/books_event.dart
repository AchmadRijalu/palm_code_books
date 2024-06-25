part of 'books_bloc.dart';

@immutable
sealed class BooksEvent extends Equatable {
  const BooksEvent();
  @override
  List<Object> get props => [];
}

class GetAllBooks extends BooksEvent {
  const GetAllBooks();
  @override
  List<Object> get props => [];
}

class GetDetailBooks extends BooksEvent {
  final int? booksId;
  GetDetailBooks(this.booksId);

  @override
  List<Object> get props => [booksId!];
}
