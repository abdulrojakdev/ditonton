import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_state.dart';

part 'movie_list_event.dart';

part 'movie_list_bloc.freezed.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.initial()) {
    on<FetchNowPlayingMoviesEvent>(_onFetchNowPlayingMoviesEvent);
    on<FetchPopularMoviesEvent>(_onFetchPopularMoviesEvent);
    on<FetchTopRatedMoviesEvent>(_onFetchTopRatedMoviesEvent);
  }

  void _onFetchNowPlayingMoviesEvent(
    FetchNowPlayingMoviesEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(
      state.copyWith(
        nowPlayingState: RequestState.Loading,
      ),
    );
    final result = await getNowPlayingMovies.execute();
    print(result);

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(state.copyWith(
            nowPlayingState: RequestState.Error,
            message: failure.message,
          ));
        } else if (failure is ConnectionFailure) {
          emit(state.copyWith(
            nowPlayingState: RequestState.Error,
            message: failure.message,
          ));
        }
      },
      (moviesData) {
        emit(
          state.copyWith(
            nowPlayingState: RequestState.Loaded,
            nowPlaying: moviesData,
          ),
        );
      },
    );
  }

  void _onFetchPopularMoviesEvent(
    FetchPopularMoviesEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state
        .copyWith(popularMoviesState: RequestState.Loading));
    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(state.copyWith(
            popularMoviesState: RequestState.Error,
            message: failure.message,
          ));
        } else if (failure is ConnectionFailure) {
          emit(state.copyWith(
            popularMoviesState: RequestState.Error,
            message: failure.message,
          ));
        }
      },
      (moviesData) {
        emit(
          state.copyWith(
            popularMoviesState: RequestState.Loaded,
            popularMovies: moviesData,
          ),
        );
      },
    );
  }

  void _onFetchTopRatedMoviesEvent(
    FetchTopRatedMoviesEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(
      topRatedMoviesState: RequestState.Loading,
    ));
    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(state.copyWith(
            topRatedMoviesState: RequestState.Error,
            message: failure.message,
          ));
        } else if (failure is ConnectionFailure) {
          emit(state.copyWith(
            topRatedMoviesState: RequestState.Error,
            message: failure.message,
          ));
        }
      },
      (moviesData) {
        emit(
          state.copyWith(
            topRatedMoviesState: RequestState.Loaded,
            topRatedMovies: moviesData,
          ),
        );
      },
    );
  }
}
