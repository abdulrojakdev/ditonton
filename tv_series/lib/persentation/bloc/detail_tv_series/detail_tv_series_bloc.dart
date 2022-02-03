import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_series/tv_series.dart';

part 'detail_tv_series_event.dart';

part 'detail_tv_series_state.dart';

part 'detail_tv_series_bloc.freezed.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetDetailSeasonsTvSeries getDetailSeasonsTvSeries;

  DetailTvSeriesBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatusTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
    required this.getDetailSeasonsTvSeries,
  }) : super(DetailTvSeriesState.initial()) {
    on<FetchTvSeriesDetailEvent>(_onFetchTvSeriesDetailEvent);
    on<FetchEpisodeTvSeriesEvent>(_onFetchEpisodeTvSeriesEvent);
    on<RemoveWatchListTvSeries>(_onRemoveWatchListTvSeries);
    on<AddWatchListTvSeries>(_onAddWatchListTvSeries);
    on<LoadWatchlistStatusEvent>(_onLoadWatchlistStatusEvent);
  }

  void _onFetchTvSeriesDetailEvent(
    FetchTvSeriesDetailEvent event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));

    final detailResult = await getTvSeriesDetail.execute(event.id);

    final recommendationResult =
        await getTvSeriesRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              tvSeriesDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              tvSeriesDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (tvSeriesData) async {
        emit(
          state.copyWith(
            tvSeriesDetailState: RequestState.Loaded,
            tvSeriesDetail: tvSeriesData,
            tvSeriesRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
        );

        recommendationResult.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(
                state.copyWith(
                  tvSeriesRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            } else if (failure is ConnectionFailure) {
              emit(
                state.copyWith(
                  tvSeriesRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            }
          },
          (tvSeriesData) {
            emit(
              state.copyWith(
                tvSeriesRecommendationsState: RequestState.Loaded,
                tvSeriesRecommendations: tvSeriesData,
                watchlistMessage: '',
                message: '',
              ),
            );
          },
        );
      },
    );
  }

  void _onFetchEpisodeTvSeriesEvent(
    FetchEpisodeTvSeriesEvent event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    emit(state.copyWith(tvSeriesSeasonsState: RequestState.Loading));
    final result =
        await getDetailSeasonsTvSeries.execute(event.idTv, event.seasonNumber);

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            state.copyWith(
              tvSeriesSeasonsState: RequestState.Error,
              message: failure.message,
            ),
          );
        } else if (failure is ConnectionFailure) {
          emit(
            state.copyWith(
              tvSeriesSeasonsState: RequestState.Error,
              message: failure.message,
            ),
          );
        }
      },
      (detailSeasons) {
        emit(
          state.copyWith(
            tvSeriesSeasonsState: RequestState.Loaded,
            tvSeriesSeasons: detailSeasons,
            watchlistMessage: '',
            message: '',
          ),
        );
      },
    );
  }

  void _onRemoveWatchListTvSeries(
    RemoveWatchListTvSeries event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    final result = await removeWatchlistTvSeries.execute(event.tvSeriesDetail);
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
        event.tvSeriesDetail.id,
      ),
    );
  }

  void _onAddWatchListTvSeries(
    AddWatchListTvSeries event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);
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
        event.tvSeriesDetail.id,
      ),
    );
  }

  void _onLoadWatchlistStatusEvent(
    LoadWatchlistStatusEvent event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    final resultStatus = await getWatchListStatusTvSeries.execute(event.id);

    emit(
      state.copyWith(
        isAddedToWatchlist: resultStatus,
      ),
    );
  }
}
