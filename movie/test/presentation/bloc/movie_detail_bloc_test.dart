import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final tId = 77169;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  final movieId = 1;

  group('Get Movie Detail', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'should get data from the usecase',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetailEvent(tId)),
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetailEvent(tId)),
        expect: () => [
          MovieDetailState.initial()
              .copyWith(movieDetailState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
          MovieDetailState.initial().copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Loaded,
            movieRecommendations: tMovies,
            watchlistMessage: '',
            message: '',
          ),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetailEvent(tId)),
        expect: () => [
          MovieDetailState.initial()
              .copyWith(movieDetailState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
            movieDetailState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetailEvent(tId)),
        expect: () => [
          MovieDetailState.initial()
              .copyWith(movieDetailState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Loading,
            watchlistMessage: '',
            message: '',
          ),
          MovieDetailState.initial().copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );
    },
  );

  group('Watch List Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'add watch list',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((_) async => true);

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchListMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
        ),
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'remove watch list',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((_) async => true);

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchListMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
        ),
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'load watch list status',
      build: () {
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusEvent(movieId)),
      expect: () => [
        MovieDetailState.initial().copyWith(isAddedToWatchlist: true),
      ],
    );
  });
}
