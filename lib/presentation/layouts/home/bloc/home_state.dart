part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BookModel> books;
  final bool hasReachedMax;

  const HomeState({
    this.status = HomeStatus.initial,
    this.books = const <BookModel>[],
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
        status,
        books,
        hasReachedMax,
      ];
}
