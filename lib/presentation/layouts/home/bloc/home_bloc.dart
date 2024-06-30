import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/common/extensions/bloc_extension.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/data/repositories/book_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeFetchEvent>(
      _onFetch,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<HomeSearchEvent>(_onSearch);
  }

  // @override
  // void add(event) {
  //   if (!isClosed) {
  //     super.add(event);
  //   }
  // }

  final BookRepository repository;

  FutureOr<void> _onFetch(HomeFetchEvent event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;

    final response = await repository.all(page: state.page, search: state.search);

    response.fold(
      (l) => safeEmit(state.copyWith(status: HomeStatus.failure, message: l.message)),
      (r) => safeEmit(
        state.copyWith(
          books: List.of(state.books)..addAll(r.results ?? <BookModel>[]),
          hasReachedMax: r.next == null,
          status: HomeStatus.success,
          page: state.page + 1,
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
          page: 2,
          hasReachedMax: r.next == null,
          status: HomeStatus.success,
          search: event.search,
        ),
      ),
    );
  }
}
