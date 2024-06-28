part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchEvent extends HomeEvent {
  final bool reset;

  const HomeFetchEvent({this.reset = false});
}

class HomeSearchEvent extends HomeEvent {
  final String? search;

  const HomeSearchEvent({this.search});
}
