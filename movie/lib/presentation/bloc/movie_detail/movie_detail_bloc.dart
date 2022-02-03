import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

part 'movie_detail_bloc.freezed.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetailEvent>(_onFetchMovieDetailEvent);
    on<LoadWatchlistStatusEvent>(_onLoadWatchlistStatusEvent);
    on<AddWatchListMovie>(_onAddWatchListMovie);
    on<RemoveWatchListMovie>(_onRemoveWatchListMovie);
  }

  void _onFetchMovieDetailEvent(
    FetchMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(movieDetailState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(event.id);

    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              movieDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              movieDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (moviesData) async {
        emit(
          state.copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: moviesData,
            movieRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
        );

        recommendationResult.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            } else if (failure is ConnectionFailure) {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            }
          },
          (moviesData) {
            emit(
              state.copyWith(
                movieRecommendationsState: RequestState.Loaded,
                movieRecommendations: moviesData,
                watchlistMessage: '',
                message: '',
              ),
            );
          },
        );
      },
    );
  }

  void _onAddWatchListMovie(
    AddWatchListMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);
    result.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          emit(
            state.copyWith(
              watchlistMessage: failure.message,
            ),
          );
        }
      },
      (successMessage) {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
      },
    );
    add(
      LoadWatchlistStatusEvent(
        event.movie.id,
      ),
    );
  }

  void _onRemoveWatchListMovie(
    RemoveWatchListMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);
    result.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          emit(
            state.copyWith(
              watchlistMessage: failure.message,
            ),
          );
        }
      },
      (successMessage) {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
      },
    );
    add(
      LoadWatchlistStatusEvent(
        event.movie.id,
      ),
    );
  }

  void _onLoadWatchlistStatusEvent(
    LoadWatchlistStatusEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final resultStatus = await getWatchListStatus.execute(event.id);

    emit(
      state.copyWith(
        isAddedToWatchlist: resultStatus,
      ),
    );
  }
}
