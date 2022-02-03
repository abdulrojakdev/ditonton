part of 'watch_list_bloc.dart';

@freezed
abstract class WatchListState with _$WatchListState {
  const factory WatchListState({
    @required RequestState? watchListMovieState,
    @required List<Movie>? watchListMovie,
    @required RequestState? watchListTvSeriesState,
    @required List<TvSeries>? watchListTvSeries,
    @required String? message,
  }) = _WatchListState;

  factory WatchListState.initial() => WatchListState(
        watchListMovieState: RequestState.Empty,
        watchListMovie: null,
        watchListTvSeriesState: RequestState.Empty,
        watchListTvSeries: null,
        message: '',
      );
}
