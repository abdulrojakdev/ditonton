import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  final tTvSeriesDetailSeasonsModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    tagline: '',
    revenue: 1,
    status: '',
    imdbId: '',
    budget: 0,
    video: true,
    popularity: 0,
    originalLanguage: '',
    homepage: '',
  );

  final tDetailSeasons = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesDetailSeasonsModel.toEntity();
    expect(result, tDetailSeasons);
  });
}
