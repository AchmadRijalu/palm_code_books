part of 'books_bloc.dart';

@immutable
sealed class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

final class BooksInitial extends BooksState {}

class GetBooksSuccess extends BooksState {
  final BooksModel? booksModel;

  GetBooksSuccess(this.booksModel);

  @override
  // TODO: implement props
  List<Object> get props => [booksModel!];
}

class GetBooksFavoriteSuccess extends BooksState {
  final List<Result>? bookResult;

  GetBooksFavoriteSuccess(this.bookResult);

  @override
  // TODO: implement props
  List<Object> get props => [bookResult!];
}

class GetBooksDetailSuccess extends BooksState {
  final DetailBooksModel? detailBooksModel;
   final bool isBookmarked;

  GetBooksDetailSuccess(this.detailBooksModel, this.isBookmarked);

  @override
  // TODO: implement props
  List<Object> get props => [detailBooksModel!, isBookmarked];
}

class BooksLoading extends BooksState {}

class BookSuccess extends BooksState {
  BookSuccess();

  @override
  List<Object> get props => [];
}

class BooksFailed extends BooksState {
  final String e;

  BooksFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e!];
}
