import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

import '../../json_reader.dart';

void main() {

  final tTvSeriesDetailModel =
  TvSeriesDetailModel(id: 77169,
      name: "Cobra Kai",
      numberEpisodes: 40,
      numberSeasons: 4,
      episodeRunTime: [
        30
      ],
      genres: [
        GenreModel(
            id: 10759,
            name: "Action & Adventure"
        ),
        GenreModel(
            id: 18,
            name: "Drama"
        ),
      ],
      originalName: "Cobra Kai",
      overview: "This Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.",
      posterPath: "/6POBWybSBDBKjSs1VAQcnQC1qyt.jpg",
      seasons: [
        SeasonsModel(
            airDate: "2018-05-02",
            episodeCount: 10,
            id: 99459,
            name : "Season 1",
            posterPath: "/lLrKXnM3WPEtrPCd1aTHT6x3hn.jpg",
            seasonNumber: 1
        )
      ],
      voteAverage: 8.1);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_series_detail.json'));
      // act
      final result = TvSeriesDetailModel.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tTvSeriesDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 77169,
        "name": "Cobra Kai",
        "number_of_episodes": 40,
        "number_of_seasons": 4,
        "episode_run_time": [
          30
        ],
        "genres": [
          {
            "id": 10759,
            "name": "Action & Adventure"
          },
          {
            "id": 18,
            "name": "Drama"
          }
        ],
        "original_name": "Cobra Kai",
        "overview": "This Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.",
        "poster_path": "/6POBWybSBDBKjSs1VAQcnQC1qyt.jpg",
        "seasons": [
          {
            "air_date": "2018-05-02",
            "episode_count": 10,
            "id": 99459,
            "name": "Season 1",
            "poster_path": "/lLrKXnM3WPEtrPCd1aTHT6x3hn.jpg",
            "season_number": 1
          }
        ],
        "vote_average": 8.1
      };
      expect(result, expectedJsonMap);
    });
  });
}
