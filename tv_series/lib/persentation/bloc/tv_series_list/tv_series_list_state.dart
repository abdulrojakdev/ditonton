part of 'tv_series_list_bloc.dart';

@freezed
abstract class TvSeriesListState with _$TvSeriesListState {
  const factory TvSeriesListState({
    @required RequestState? noPlayingTvSeriesState,
    @required List<TvSeries>? noPlayingTvSeries,
    @required RequestState? popularTvSeriesState,
    @required List<TvSeries>? popularTvSeries,
    @required RequestState? topRatedTvSeriesState,
    @required List<TvSeries>? topRatedTvSeries,
    @required String? message,
  }) = _TvSeriesListState;

  factory TvSeriesListState.initial() => TvSeriesListState(
        noPlayingTvSeriesState: RequestState.Empty,
        noPlayingTvSeries: null,
        popularTvSeriesState: RequestState.Empty,
        popularTvSeries: null,
        topRatedTvSeriesState: RequestState.Empty,
        topRatedTvSeries: null,
        message: '',
      );
}
