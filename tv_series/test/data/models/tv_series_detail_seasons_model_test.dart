import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  final tTvSeriesDetailSeasonsModel = TvSeriesDetailSeasonsModel(
    id: 1,
    episodes: [
      TvSeriesEpisodeModel(
        id: 1,
        name: "Name",
        episodeNumber: 1,
        overview: "Overview",
        stillPath: '/path.jpg',
      ),
    ],
  );

  final tDetailSeasons = DetailSeasons(
    id: 1,
    episodes: [
      Episode(
        id: 1,
        name: "Name",
        episodeNumber: 1,
        overview: "Overview",
        stillPath: '/path.jpg',
      ),
    ],
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesDetailSeasonsModel.toEntity();
    expect(result, tDetailSeasons);
  });
}
