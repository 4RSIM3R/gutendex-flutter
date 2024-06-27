part of 'home_bloc.dart';



abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchEvent extends HomeEvent {}

class HomeSearchEvent extends HomeEvent {
  final String? search;

  const HomeSearchEvent({required this.search});
}
