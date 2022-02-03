import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

part 'watch_list_event.dart';

part 'watch_list_state.dart';

part 'watch_list_bloc.freezed.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final GetWatchlistMovies getWatchlistMovies;

  WatchListBloc({
    required this.getWatchlistMovies,
    required this.getWatchlistTvSeries,
  }) : super(WatchListState.initial()) {
    on<GetWatchListMovieEvent>(_onGetWatchListMovieEvent);
    on<GetWatchListTvSeriesEvent>(_onGetWatchListTvSeriesEvent);
  }

  void _onGetWatchListTvSeriesEvent(
    GetWatchListTvSeriesEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(state.copyWith(watchListTvSeriesState: RequestState.Loading));
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          emit(
            state.copyWith(
              watchListTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (tvSeriesData) {
        emit(
          state.copyWith(
            watchListTvSeriesState: RequestState.Loaded,
            watchListTvSeries: tvSeriesData,
          ),
        );
      },
    );
  }

  void _onGetWatchListMovieEvent(
    GetWatchListMovieEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(state.copyWith(watchListMovieState: RequestState.Loading));
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          emit(
            state.copyWith(
              watchListMovieState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (movieData) {
        emit(
          state.copyWith(
            watchListMovieState: RequestState.Loaded,
            watchListMovie: movieData,
          ),
        );
      },
    );
  }
}
