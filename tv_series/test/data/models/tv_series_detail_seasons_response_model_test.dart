import 'dart:convert';

import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tEpisode = TvSeriesEpisodeModel(
      id: 1433787,
      name: "Ace Degenerate",
      episodeNumber: 1,
      overview: "Thirty years after the events of the 1984 All Valley Karate Tournament, Johnny Lawrence’s life has taken a rocky turn as he tries to forget a past that constantly haunts him. He seeks redemption by reopening the infamous Cobra Kai karate dojo. But the LaRusso-Lawrence rivalry of yesteryear is reignited when their lives become intertwined with the next generation of “karate kids.”",
      stillPath: "/pU6SRSRhC9sSZoSwHqSpGMocpfQ.jpg"
  );

  final tTvSeriesDetailSeasons = TvSeriesDetailSeasonsModel(id: 99459, episodes: <TvSeriesEpisodeModel>[tEpisode]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/seasons_tv_series.json'));
      // act
      final result = TvSeriesDetailSeasonsModel.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesDetailSeasons);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesDetailSeasons.toJson();
      // assert
      final expectedJsonMap = {
        "id": 99459,
        "episodes": [
          {
            "id": 1433787,
            "name": "Ace Degenerate",
            "episode_number": 1,
            "overview": "Thirty years after the events of the 1984 All Valley Karate Tournament, Johnny Lawrence’s life has taken a rocky turn as he tries to forget a past that constantly haunts him. He seeks redemption by reopening the infamous Cobra Kai karate dojo. But the LaRusso-Lawrence rivalry of yesteryear is reignited when their lives become intertwined with the next generation of “karate kids.”",
            "still_path": "/pU6SRSRhC9sSZoSwHqSpGMocpfQ.jpg"
          },
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
