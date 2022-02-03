part of 'watch_list_bloc.dart';

abstract class WatchListEvent extends Equatable {
  const WatchListEvent();
}

class GetWatchListMovieEvent extends WatchListEvent {
  @override
  List<Object?> get props => [];
}

class GetWatchListTvSeriesEvent extends WatchListEvent {
  @override
  List<Object?> get props => [];
}
