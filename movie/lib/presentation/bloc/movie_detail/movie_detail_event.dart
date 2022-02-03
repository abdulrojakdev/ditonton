part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;

  FetchMovieDetailEvent(this.id);

  @override
  List<Object?> get props => [id];

}

class LoadWatchlistStatusEvent extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];

}

class RemoveWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveWatchListMovie(this.movie);

  @override
  List<Object?> get props => [movie];

}

class AddWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  AddWatchListMovie(this.movie);

  @override
  List<Object?> get props => [movie];

}