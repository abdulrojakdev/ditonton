part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class FetchTopRatedMoviesEvent extends MovieListEvent {
  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMoviesEvent extends MovieListEvent {
  @override
  List<Object?> get props => [];
}

class FetchPopularMoviesEvent extends MovieListEvent {
  @override
  List<Object?> get props => [];
}
