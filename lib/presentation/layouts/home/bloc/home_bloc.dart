import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/data/repositories/book_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeFetchEvent>(_onFetch);
    on<HomeSearchEvent>(_onSearch);
  }

  final BookRepository repository;

  FutureOr<void> _onFetch(HomeFetchEvent event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;

    final response = await repository.all(page: state.page, search: state.search);

    response.fold(
      (l) => emit(state.copyWith(status: HomeStatus.failure, message: l.message)),
      (r) => r.next != null
          ? emit(
              state.copyWith(
                books: r.results ?? <BookModel>[],
                page: state.page + 1,
                hasReachedMax: false,
                status: HomeStatus.success,
              ),
            )
          : emit(
              state.copyWith(
                books: r.results ?? <BookModel>[],
                hasReachedMax: true,
                status: HomeStatus.success,
              ),
            ),
    );
  }

  FutureOr<void> _onSearch(HomeSearchEvent event, Emitter<HomeState> emit) async {}
}
