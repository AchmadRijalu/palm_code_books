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

class GetBooksDetailSuccess extends BooksState {
  final DetailBooksModel? detailBooksModel;

  GetBooksDetailSuccess(this.detailBooksModel);

  @override
  // TODO: implement props
  List<Object> get props => [detailBooksModel!];
}

class BooksLoading extends BooksState {}

class BooksFailed extends BooksState {
  final String e;

  BooksFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e!];
}
