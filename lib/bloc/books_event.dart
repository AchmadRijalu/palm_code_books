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

class GetAllBooksFavorite extends BooksEvent {
  const GetAllBooksFavorite();
  @override
  List<Object> get props => [];
}

class GetDetailBooks extends BooksEvent {
  final int? booksId;
  GetDetailBooks(this.booksId);

  @override
  List<Object> get props => [booksId!];
}

class AddFavoriteBooks extends BooksEvent {
  final Result? result;
  
  AddFavoriteBooks(this.result);

  @override
  List<Object> get props => [result!];
}

class RemoveFavoriteBooks extends BooksEvent {
  final int? result;
  RemoveFavoriteBooks(this.result);

  @override
  List<Object> get props => [result!];
}

class CheckIfBookmarked extends BooksEvent {
  final int id;

  const CheckIfBookmarked(this.id);

  @override
  List<Object> get props => [id];
}
