import 'dart:convert';

import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
  );

  final tTvSeriesResponseModel =
  TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_series_now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": "Name",
            "original_name": "Original Name",
            "overview": "Overview",
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
