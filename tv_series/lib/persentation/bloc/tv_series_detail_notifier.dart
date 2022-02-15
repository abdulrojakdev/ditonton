// import 'package:core/core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:tv_series/domain/entities/detail_seasons.dart';
// import 'package:tv_series/domain/entities/tv_series.dart';
// import 'package:tv_series/domain/entities/tv_series_detail.dart';
// import 'package:tv_series/domain/usecases/get_detail_seasons_tv_series.dart';
// import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
// import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
// import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
// import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
// import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';
//
// class TvSeriesDetailNotifier extends ChangeNotifier {
//   static const watchlistAddSuccessMessage = 'Added to Watchlist';
//   static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
//
//   final GetTvSeriesDetail getTvSeriesDetail;
//   final GetTvSeriesRecommendations getTvSeriesRecommendations;
//   final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
//   final SaveWatchlistTvSeries saveWatchlistTvSeries;
//   final RemoveWatchlistTvSeries removeWatchlistTvSeries;
//   final GetDetailSeasonsTvSeries getDetailSeasonsTvSeries;
//
//   TvSeriesDetailNotifier({
//     required this.getTvSeriesDetail,
//     required this.getTvSeriesRecommendations,
//     required this.getWatchListStatusTvSeries,
//     required this.saveWatchlistTvSeries,
//     required this.removeWatchlistTvSeries,
//     required this.getDetailSeasonsTvSeries,
//   });
//
//   late TvSeriesDetail _tvSeries;
//
//   TvSeriesDetail get tvSeries => _tvSeries;
//
//   RequestState _tvSeriesState = RequestState.Empty;
//
//   RequestState get tvSeriesState => _tvSeriesState;
//
//   late DetailSeasons _detailSeasons;
//
//   DetailSeasons get detailSeasons => _detailSeasons;
//
//   RequestState _detailSeasonsState = RequestState.Empty;
//
//   RequestState get detailSeasonsState => _detailSeasonsState;
//
//   List<TvSeries> _tvSeriesRecommendations = [];
//
//   List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;
//
//   RequestState _recommendationState = RequestState.Empty;
//
//   RequestState get recommendationState => _recommendationState;
//
//   String _message = '';
//
//   String get message => _message;
//
//   bool _isAddedtoWatchlist = false;
//
//   bool get isAddedToWatchlist => _isAddedtoWatchlist;
//
//   Future<void> fetchTvSeriesDetail(int id) async {
//     _tvSeriesState = RequestState.Loading;
//     notifyListeners();
//     final detailResult = await getTvSeriesDetail.execute(id);
//     final recommendationResult = await getTvSeriesRecommendations.execute(id);
//     detailResult.fold(
//       (failure) {
//         _tvSeriesState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (tvSeries) {
//         _recommendationState = RequestState.Loading;
//         _tvSeries = tvSeries;
//         notifyListeners();
//         recommendationResult.fold(
//           (failure) {
//             _recommendationState = RequestState.Error;
//             _message = failure.message;
//           },
//           (tvSeries) {
//             _recommendationState = RequestState.Loaded;
//             _tvSeriesRecommendations = tvSeries;
//           },
//         );
//         _tvSeriesState = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
//
//   Future<void> fetchDetailSeasonsTvSeries(int id, int seasonNumber) async {
//     _detailSeasonsState = RequestState.Loading;
//     notifyListeners();
//     final detailResult = await getDetailSeasonsTvSeries.execute(id, seasonNumber);
//     detailResult.fold(
//       (failure) {
//         _detailSeasonsState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (detailSeasons) {
//         _detailSeasons = detailSeasons!;
//         _detailSeasonsState = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
//
//   String _watchlistMessage = '';
//
//   String get watchlistMessage => _watchlistMessage;
//
//   Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
//     final result = await saveWatchlistTvSeries.execute(tvSeries);
//
//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );
//
//     await loadWatchlistStatus(tvSeries.id);
//   }
//
//   Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
//     final result = await removeWatchlistTvSeries.execute(tvSeries);
//
//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );
//
//     await loadWatchlistStatus(tvSeries.id);
//   }
//
//   Future<void> loadWatchlistStatus(int id) async {
//
//     final result = await getWatchListStatusTvSeries.execute(id);
//     _isAddedtoWatchlist = result;
//     notifyListeners();
//   }
// }
