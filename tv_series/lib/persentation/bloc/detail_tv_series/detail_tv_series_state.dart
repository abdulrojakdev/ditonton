part of 'detail_tv_series_bloc.dart';

@freezed
abstract class DetailTvSeriesState with _$DetailTvSeriesState {
  const factory DetailTvSeriesState({
    @required RequestState? tvSeriesDetailState,
    @required TvSeriesDetail? tvSeriesDetail,
    @required RequestState? tvSeriesRecommendationsState,
    @required List<TvSeries>? tvSeriesRecommendations,
    @required RequestState? tvSeriesSeasonsState,
    @required DetailSeasons? tvSeriesSeasons,
    @required String? message,
    @required bool? isAddedToWatchlist,
    @required String? watchlistMessage,
  }) = _DetailTvSeriesState;

  factory DetailTvSeriesState.initial() => DetailTvSeriesState(
        tvSeriesDetailState: RequestState.Empty,
        tvSeriesDetail: null,
        tvSeriesRecommendationsState: RequestState.Empty,
        tvSeriesRecommendations: null,
        tvSeriesSeasonsState: RequestState.Empty,
        tvSeriesSeasons: null,
        message: '',
        isAddedToWatchlist: false,
        watchlistMessage: '',
      );
}
