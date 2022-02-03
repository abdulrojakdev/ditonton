import 'dart:convert';

import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tEpisodeTvSeriesResponseModel = TvSeriesEpisodeModel(
    id: 557,
    name: 'Cobra Kai',
    overview:
    'his Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
    stillPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    episodeNumber: 1,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/episode_tv_series.json'));
      // act
      final result = TvSeriesEpisodeModel.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tEpisodeTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 557,
        "name": "Cobra Kai",
        "overview":
        "his Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.",
        "still_path": "/rweIrveL43TaxUN0akQEaAXL6x0.jpg",
        "episode_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
