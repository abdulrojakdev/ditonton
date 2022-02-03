part of 'movie_detail_bloc.dart';

@freezed
abstract class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    @required RequestState? movieDetailState,
    @required MovieDetail? movieDetail,
    @required RequestState? movieRecommendationsState,
    @required List<Movie>? movieRecommendations,
    @required String? message,
    @required bool? isAddedToWatchlist,
    @required String? watchlistMessage,
  }) = _MovieDetailState;

  factory MovieDetailState.initial() => MovieDetailState(
        movieDetailState: RequestState.Empty,
        movieDetail: null,
        movieRecommendationsState: RequestState.Empty,
        movieRecommendations: null,
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );
}
