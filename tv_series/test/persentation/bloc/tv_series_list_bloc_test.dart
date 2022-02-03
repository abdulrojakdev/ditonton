import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/persentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetNowPlayingTvSeries,
])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
    );
  });

  final tTvSeries = TvSeries(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Get Now Playing Tv Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
        'should get data from the usecase',
        build: () {
          when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => Right(tTvSeriesList),
          );
          return tvSeriesListBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        });

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get tv series success',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
          (_) async => Right(tTvSeriesList),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          noPlayingTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          noPlayingTvSeriesState: RequestState.Loaded,
          noPlayingTvSeries: tTvSeriesList,
        )
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get tv series failure',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial()
            .copyWith(noPlayingTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          noPlayingTvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Get Popular Movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
        'should get data from the usecase',
        build: () {
          when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => Right(tTvSeriesList),
          );
          return tvSeriesListBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTvSeries()),
        verify: (bloc) {
          verify(mockGetPopularTvSeries.execute());
        });

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get movie success',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
          (_) async => Right(tTvSeriesList),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesListState.initial()
            .copyWith(popularTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get movie failure',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesListState.initial()
            .copyWith(popularTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Get Top Rated Movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
        'should get data from the usecase',
        build: () {
          when(mockGetTopRatedTvSeries.execute()).thenAnswer(
                (_) async => Right(tTvSeriesList),
          );
          return tvSeriesListBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        }
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get movie success',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
              (_) async => Right(tTvSeriesList),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TvSeriesListState.initial()
            .copyWith(topRatedTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'get movie failure',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TvSeriesListState.initial()
            .copyWith(topRatedTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
