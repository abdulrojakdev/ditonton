import 'dart:convert';

import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {

  final tMovieDetailModel = MovieDetailResponse(
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



  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/movie_detail.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tMovieDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": 'backdropPath',
        "genres": [{"id": 1, "name": 'Action'}],
        "id": 1,
        "original_title": 'originalTitle',
        "overview": 'overview',
        "poster_path": 'posterPath',
        "release_date": 'releaseDate',
        "runtime": 120,
        "title": 'title',
        "vote_average": 1,
        "vote_count": 1,
        "tagline": '',
        "revenue": 1,
        "status": '',
        "imdb_id": '',
        "budget": 0,
        "video": true,
        "popularity": 0,
        "original_language": '',
        "homepage": '',
      };
      expect(result, expectedJsonMap);
    });
  });
}
