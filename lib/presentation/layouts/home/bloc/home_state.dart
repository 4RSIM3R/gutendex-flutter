part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BookModel> books;
  final bool hasReachedMax;
  final int page;
  final String? search;
  final String? message;

  const HomeState({
    this.status = HomeStatus.initial,
    this.books = const <BookModel>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.search,
    this.message,
  });

  @override
  List<Object?> get props => [status, books, hasReachedMax, page, search, message];

  HomeState copyWith({
    HomeStatus? status,
    List<BookModel>? books,
    bool? hasReachedMax,
    int? page,
    String? search,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
      page: page ?? this.page,
      search: search ?? this.search,
    );
  }
}
