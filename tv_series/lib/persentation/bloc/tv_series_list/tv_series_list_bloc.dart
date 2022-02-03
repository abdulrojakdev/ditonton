import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_list_event.dart';

part 'tv_series_list_state.dart';

part 'tv_series_list_bloc.freezed.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesListBloc({
    required this.getTopRatedTvSeries,
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
  }) : super(TvSeriesListState.initial()) {
    on<FetchNowPlayingTvSeries>(_onFetchNowPlayingTvSeries);
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  void _onFetchNowPlayingTvSeries(
    FetchNowPlayingTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(
      state.copyWith(
        noPlayingTvSeriesState: RequestState.Loading,
      ),
    );
    final result = await getNowPlayingTvSeries.execute();

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              noPlayingTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              noPlayingTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (tvSeriesData) {
        emit(state.copyWith(
          noPlayingTvSeriesState: RequestState.Loaded,
          noPlayingTvSeries: tvSeriesData,
        ));
      },
    );
  }

  void _onFetchPopularTvSeries(
    FetchPopularTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(
      state.copyWith(
        popularTvSeriesState: RequestState.Loading,
      ),
    );
    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              popularTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              popularTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (tvSeriesData) {
        emit(state.copyWith(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tvSeriesData,
        ));
      },
    );
  }

  void _onFetchTopRatedTvSeries(
    FetchTopRatedTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(
      state.copyWith(
        topRatedTvSeriesState: RequestState.Loading,
      ),
    );
    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              topRatedTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              topRatedTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (tvSeriesData) {
        emit(state.copyWith(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tvSeriesData,
        ));
      },
    );
  }
}
