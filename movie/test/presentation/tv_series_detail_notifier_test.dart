// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/data/models/tv_series_detail_seasons_model.dart';
// import 'package:ditonton/data/models/tv_series_episode_model.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_detail_seasons_tv_series.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
// import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
// import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
// import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
// import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import '../../dummy_data/dummy_objects.dart';
// import 'tv_series_detail_notifier_test.mocks.dart';
//
// @GenerateMocks([
//   GetTvSeriesDetail,
//   GetTvSeriesRecommendations,
//   GetWatchListStatusTvSeries,
//   SaveWatchlistTvSeries,
//   RemoveWatchlistTvSeries,
//   GetDetailSeasonsTvSeries,
// ])
// void main() {
//   late TvSeriesDetailNotifier provider;
//   late MockGetTvSeriesDetail mockGetTvSeriesDetail;
//   late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
//   late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
//   late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
//   late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
//   late MockGetDetailSeasonsTvSeries mockGetDetailSeasonsTvSeries;
//   late int listenerCallCount;
//
//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTvSeriesDetail = MockGetTvSeriesDetail();
//     mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
//     mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
//     mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
//     mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
//     mockGetDetailSeasonsTvSeries = MockGetDetailSeasonsTvSeries();
//     provider = TvSeriesDetailNotifier(
//       getTvSeriesDetail: mockGetTvSeriesDetail,
//       getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
//       getWatchListStatusTvSeries: mockGetWatchListStatusTvSeries,
//       saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
//       removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
//       getDetailSeasonsTvSeries: mockGetDetailSeasonsTvSeries,
//     )..addListener(() {
//       listenerCallCount += 1;
//     });
//   });
//
//   // final tId = 1;
//   final tId = 77169;
//   final tSeasonNumber = 1;
//
//   final tTvSeries = TvSeries(
//     id: 1,
//     name: 'name',
//     originalName: 'originalName',
//     overview: 'overview',
//     posterPath: 'posterPath',
//     voteAverage: 1,
//   );
//
//   final tTvSeriesList = <TvSeries>[tTvSeries];
//
//   void _arrangeUsecase() {
//     when(mockGetTvSeriesDetail.execute(tId))
//         .thenAnswer((_) async => Right(testTvSeriesDetail));
//     when(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber))
//         .thenAnswer((_) async => Right(testSeasonsTvSeries));
//     when(mockGetTvSeriesRecommendations.execute(tId))
//         .thenAnswer((_) async => Right(tTvSeriesList));
//   }
//
//   group('Get Tv Series Detail', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       verify(mockGetTvSeriesDetail.execute(tId));
//       verify(mockGetTvSeriesRecommendations.execute(tId));
//     });
//
//     test('should change state to Loading when usecase is called', () {
//       // arrange
//       _arrangeUsecase();
//       // act
//       provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.tvSeriesState, RequestState.Loading);
//       expect(listenerCallCount, 1);
//     });
//
//     test('should change tv series when data is gotten successfully', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.tvSeriesState, RequestState.Loaded);
//       expect(provider.tvSeries, testTvSeriesDetail);
//       expect(listenerCallCount, 3);
//     });
//
//     test('should change recommendation tv series when data is gotten successfully',
//             () async {
//           // arrange
//           _arrangeUsecase();
//           // act
//           await provider.fetchTvSeriesDetail(tId);
//           // assert
//           expect(provider.tvSeriesState, RequestState.Loaded);
//           expect(provider.tvSeriesRecommendations, tTvSeriesList);
//         });
//   });
//
//   group('Get Seasons Tv Series', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await provider.fetchDetailSeasonsTvSeries(tId, tSeasonNumber);
//       // assert
//       verify(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber));
//     });
//
//     test('should change state to Loading when usecase is called', () {
//       // arrange
//       _arrangeUsecase();
//       // act
//       provider.fetchDetailSeasonsTvSeries(tId, tSeasonNumber);
//       // assert
//       expect(provider.detailSeasonsState, RequestState.Loading);
//       expect(listenerCallCount, 1);
//     });
//
//     test('should change seasons tv series when data is gotten successfully', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await provider.fetchDetailSeasonsTvSeries(tId, tSeasonNumber);
//       // assert
//       expect(provider.detailSeasonsState, RequestState.Loaded);
//       expect(provider.detailSeasons, testSeasonsTvSeries);
//     });
//
//     test('should update error message when request in successful', () async {
//       // arrange
//       when(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber))
//           .thenAnswer((_) async => Right(testSeasonsTvSeries));
//       when(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber))
//           .thenAnswer((_) async => Left(ServerFailure('Failed')));
//       // act
//       await provider.fetchDetailSeasonsTvSeries(tId, tSeasonNumber);
//       // assert
//       expect(provider.detailSeasonsState, RequestState.Error);
//       expect(provider.message, 'Failed');
//     });
//   });
//
//   group('Get Tv Series Recommendations', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       verify(mockGetTvSeriesRecommendations.execute(tId));
//       expect(provider.tvSeriesRecommendations, tTvSeriesList);
//     });
//
//     test('should update recommendation state when data is gotten successfully',
//             () async {
//           // arrange
//           _arrangeUsecase();
//           // act
//           await provider.fetchTvSeriesDetail(tId);
//           // assert
//           expect(provider.recommendationState, RequestState.Loaded);
//           expect(provider.tvSeriesRecommendations, tTvSeriesList);
//         });
//
//     test('should update error message when request in successful', () async {
//       // arrange
//       when(mockGetTvSeriesDetail.execute(tId))
//           .thenAnswer((_) async => Right(testTvSeriesDetail));
//       when(mockGetTvSeriesRecommendations.execute(tId))
//           .thenAnswer((_) async => Left(ServerFailure('Failed')));
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.Error);
//       expect(provider.message, 'Failed');
//     });
//   });
//
//   group('Watchlist', () {
//     test('should get the watchlist status', () async {
//       // arrange
//       when(mockGetWatchListStatusTvSeries.execute(1)).thenAnswer((_) async => true);
//       // act
//       await provider.loadWatchlistStatus(1);
//       // assert
//       expect(provider.isAddedToWatchlist, true);
//     });
//
//     test('should execute save watchlist when function called', () async {
//       // arrange
//       when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
//           .thenAnswer((_) async => Right('Success'));
//       when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(testTvSeriesDetail);
//       // assert
//       verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
//     });
//
//     test('should execute remove watchlist when function called', () async {
//       // arrange
//       when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
//           .thenAnswer((_) async => Right('Removed'));
//       when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.removeFromWatchlist(testTvSeriesDetail);
//       // assert
//       verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
//     });
//
//     test('should execute remove watchlis failed', () async {
//       // arrange
//       when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
//           .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
//       when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.removeFromWatchlist(testTvSeriesDetail);
//       // assert
//       expect(provider.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//
//     test('should update watchlist status when add watchlist success', () async {
//       // arrange
//       when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
//           .thenAnswer((_) async => Right('Added to Watchlist'));
//       when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(testTvSeriesDetail);
//       // assert
//       verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
//       expect(provider.isAddedToWatchlist, true);
//       expect(provider.watchlistMessage, 'Added to Watchlist');
//       expect(listenerCallCount, 1);
//     });
//
//     test('should update watchlist message when add watchlist failed', () async {
//       // arrange
//       when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
//           .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
//       when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.addWatchlist(testTvSeriesDetail);
//       // assert
//       expect(provider.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//   });
//
//   group('on Error', () {
//     test('should return error when data is unsuccessful', () async {
//       // arrange
//       when(mockGetTvSeriesDetail.execute(tId))
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       when(mockGetTvSeriesRecommendations.execute(tId))
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.tvSeriesState, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }