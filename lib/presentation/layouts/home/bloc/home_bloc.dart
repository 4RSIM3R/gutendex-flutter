import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/data/repositories/book_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeFetchEvent>((event, emit) => null);
    on<HomeSearchEvent>((event, emit) => null);
  }

  final BookRepository repository;
}
