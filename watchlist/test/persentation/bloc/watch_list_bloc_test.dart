import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/bloc/watch_list_bloc.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_objects.dart';
import 'watch_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistTvSeries,
])
void main() {
  late WatchListBloc watchListBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchListBloc = WatchListBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
  });

  blocTest<WatchListBloc, WatchListState>(
    'Get Watch List Movie Success',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchListBloc;
    },
    act: (bloc) => bloc.add(GetWatchListMovieEvent()),
    expect: () => [
      WatchListState.initial().copyWith(
        watchListMovieState: RequestState.Loading,
      ),
      WatchListState.initial().copyWith(
        watchListMovieState: RequestState.Loaded,
        watchListMovie: testMovieList,
      ),
    ],
  );

  blocTest<WatchListBloc, WatchListState>(
    'Get Watch List Movie Failure',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("No Data")));
      return watchListBloc;
    },
    act: (bloc) => bloc.add(GetWatchListMovieEvent()),
    expect: () => [
      WatchListState.initial().copyWith(
        watchListMovieState: RequestState.Loading,
      ),
      WatchListState.initial().copyWith(
        watchListMovieState: RequestState.Error,
        message: 'No Data',
      ),
    ],
  );

  blocTest<WatchListBloc, WatchListState>(
    'Get Watch List Tv Series Success',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return watchListBloc;
    },
    act: (bloc) => bloc.add(GetWatchListTvSeriesEvent()),
    expect: () => [
      WatchListState.initial().copyWith(
        watchListTvSeriesState: RequestState.Loading,
      ),
      WatchListState.initial().copyWith(
        watchListTvSeriesState: RequestState.Loaded,
        watchListTvSeries: testTvSeriesList,
      ),
    ],
  );

  blocTest<WatchListBloc, WatchListState>(
    'Get Watch List Tv Series Failure',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("No Data")));
      return watchListBloc;
    },
    act: (bloc) => bloc.add(GetWatchListTvSeriesEvent()),
    expect: () => [
      WatchListState.initial().copyWith(
        watchListTvSeriesState: RequestState.Loading,
      ),
      WatchListState.initial().copyWith(
        watchListTvSeriesState: RequestState.Error,
        message: 'No Data',
      ),
    ],
  );
}
