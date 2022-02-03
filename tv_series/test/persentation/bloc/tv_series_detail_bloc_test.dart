import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/persentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetDetailSeasonsTvSeries
])
void main() {
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockGetDetailSeasonsTvSeries mockGetDetailSeasonsTvSeries;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetDetailSeasonsTvSeries = MockGetDetailSeasonsTvSeries();
    detailTvSeriesBloc = DetailTvSeriesBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatusTvSeries: mockGetWatchListStatusTvSeries,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
      getDetailSeasonsTvSeries: mockGetDetailSeasonsTvSeries,
    );
  });

  final tId = 557;

  final tSeasonNumber = 1;

  final tTvSeries = TvSeries(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group(
    'Get Tv Series Detail',
    () {
      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'should get data from the usecase',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesDetail));
          when(mockGetTvSeriesRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tTvSeriesList));
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesDetailEvent(tId)),
        verify: (bloc) {
          verify(mockGetTvSeriesDetail.execute(tId));
          verify(mockGetTvSeriesRecommendations.execute(tId));
        },
      );

      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesDetail));
          when(mockGetTvSeriesRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tTvSeriesList));

          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesDetailEvent(tId)),
        expect: () => [
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Loading,
          ),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Loaded,
            tvSeriesDetail: testTvSeriesDetail,
            tvSeriesRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Loaded,
            tvSeriesDetail: testTvSeriesDetail,
            tvSeriesRecommendationsState: RequestState.Loaded,
            tvSeriesRecommendations: tTvSeriesList,
            watchlistMessage: '',
            message: '',
          )
        ],
      );

      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'Should emit [Loading, Error] when data is gotten successfully',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesDetailEvent(tId)),
        expect: () => [
          DetailTvSeriesState.initial()
              .copyWith(tvSeriesDetailState: RequestState.Loading),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );

      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'Should emit [Loading, Error] when data is gotten successfully',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesDetail));
          when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesDetailEvent(tId)),
        expect: () => [
          DetailTvSeriesState.initial()
              .copyWith(tvSeriesDetailState: RequestState.Loading),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Loaded,
            tvSeriesDetail: testTvSeriesDetail,
            tvSeriesRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesDetailState: RequestState.Loaded,
            tvSeriesDetail: testTvSeriesDetail,
            tvSeriesRecommendationsState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );

      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'get episode tv series success',
        build: () {
          when(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber))
              .thenAnswer((_) async => Right(testSeasonsTvSeries));
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchEpisodeTvSeriesEvent(tId, tSeasonNumber)),
        expect: () => [
          DetailTvSeriesState.initial().copyWith(
            tvSeriesSeasonsState: RequestState.Loading,
          ),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesSeasonsState: RequestState.Loaded,
            tvSeriesSeasons: testSeasonsTvSeries,
            watchlistMessage: '',
            message: '',
          ),
        ],
      );

      blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        'get episode tv series failure',
        build: () {
          when(mockGetDetailSeasonsTvSeries.execute(tId, tSeasonNumber))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchEpisodeTvSeriesEvent(tId, tSeasonNumber)),
        expect: () => [
          DetailTvSeriesState.initial().copyWith(
            tvSeriesSeasonsState: RequestState.Loading,
          ),
          DetailTvSeriesState.initial().copyWith(
            tvSeriesSeasonsState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );
    },
  );

  group('Watch List Tv Series', () {
    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'add watch list',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatusTvSeries.execute(1))
            .thenAnswer((_) async => true);

        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchListTvSeries(testTvSeriesDetail)),
      expect: () => [
        DetailTvSeriesState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
        ),
        DetailTvSeriesState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'remove watch list',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchListStatusTvSeries.execute(1))
            .thenAnswer((_) async => true);

        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchListTvSeries(testTvSeriesDetail)),
      expect: () => [
        DetailTvSeriesState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
        ),
        DetailTvSeriesState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'load watch list status',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(1))
            .thenAnswer((_) async => true);
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusEvent(1)),
      expect: () => [
        DetailTvSeriesState.initial().copyWith(isAddedToWatchlist: true),
      ],
    );
  });
}
