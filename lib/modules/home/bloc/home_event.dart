part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchDataForHomeEvent extends HomeEvent {}

class ChangeStatsEvent extends HomeEvent {
  final ViewStats newStats;
  final FilterCondition newFilterCondition;

  const ChangeStatsEvent({
    required this.newStats,
    required this.newFilterCondition,
  });
}
