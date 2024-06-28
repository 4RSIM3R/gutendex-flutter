import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/common/extensions/bloc_extension.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/data/repositories/book_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeFetchEvent>(_onFetch);
    on<HomeSearchEvent>(_onSearch);
  }

  @override
  void add(event) {
    if (!isClosed) {
      super.add(event);
    }
  }

  final BookRepository repository;

  FutureOr<void> _onFetch(HomeFetchEvent event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;

    if (event.reset) safeEmit(state.copyWith(status: HomeStatus.initial, books: []));

    print('Request to page : ${state.page}');

    final response = await repository.all(page: state.page, search: state.search);

    response.fold(
      (l) => safeEmit(state.copyWith(status: HomeStatus.failure, message: l.message)),
      (r) => r.next != null
          ? safeEmit(
              state.copyWith(
                books: List.of(state.books)..addAll(r.results ?? <BookModel>[]),
                page: state.page + 1,
                hasReachedMax: false,
                status: HomeStatus.success,
              ),
            )
          : safeEmit(
              state.copyWith(
                books: List.of(state.books)..addAll(r.results ?? <BookModel>[]),
                hasReachedMax: true,
                status: HomeStatus.success,
              ),
            ),
    );
  }

  FutureOr<void> _onSearch(HomeSearchEvent event, Emitter<HomeState> emit) async {
    safeEmit(state.copyWith(books: [], status: HomeStatus.initial));

    final response = await repository.all(page: 1, search: event.search);

    response.fold(
      (l) => safeEmit(state.copyWith(status: HomeStatus.failure, message: l.message)),
      (r) => safeEmit(
        state.copyWith(
          books: state.books..addAll(r.results ?? <BookModel>[]),
          page: 1,
          hasReachedMax: false,
          status: HomeStatus.success,
        ),
      ),
    );
  }
}
