import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

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
  final tMovieList = <Movie>[tMovie];

  group('Get Now Playing Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      }
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie success',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(nowPlayingState: RequestState.Loading),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlaying: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie failure',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(nowPlayingState: RequestState.Loading),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Get Popular Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      }
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie success',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(popularMoviesState: RequestState.Loading),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie failure',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(popularMoviesState: RequestState.Loading),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Get Top Rated Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      }
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie success',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(topRatedMoviesState: RequestState.Loading),
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'get movie failure',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        MovieListState.initial()
            .copyWith(topRatedMoviesState: RequestState.Loading),
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
