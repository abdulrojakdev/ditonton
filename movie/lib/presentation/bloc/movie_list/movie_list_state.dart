part of 'movie_list_bloc.dart';

@freezed
abstract class MovieListState with _$MovieListState {
  const factory MovieListState({
    @required RequestState? popularMoviesState,
    @required List<Movie>? popularMovies,
    @required RequestState? nowPlayingState,
    @required List<Movie>? nowPlaying,
    @required RequestState? topRatedMoviesState,
    @required List<Movie>? topRatedMovies,
    @required String? message,
  }) = _MovieListState;

  factory MovieListState.initial() => MovieListState(
    popularMoviesState: RequestState.Empty,
    popularMovies: null,
    nowPlayingState: RequestState.Empty,
    nowPlaying: null,
    topRatedMoviesState: RequestState.Empty,
    topRatedMovies: null,
    message: ''
  );
}
