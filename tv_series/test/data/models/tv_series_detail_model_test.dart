import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  final tTvSerieDetailsModel = TvSeriesDetailModel(
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    genres: [GenreModel(id: 1, name: 'Action')],
    seasons: [
      SeasonsModel(
        id: 1,
        name: 'name',
        posterPath: '/path.jpg',
        episodeCount: 12,
        airDate: '2018-05-02',
        seasonNumber: 1,
      )
    ],
    episodeRunTime: [40],
    numberSeasons: 4,
    numberEpisodes: 40,
  );

  final tTvSeriesDetail = TvSeriesDetail(
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    genres: [Genre(id: 1, name: 'Action')],
    seasons: [
      Seasons(
        id: 1,
        name: 'name',
        posterPath: '/path.jpg',
        episodeCount: 12,
        airDate: '2018-05-02',
        seasonNumber: 1,
      )
    ],
    episodeRunTime: [40],
    numberSeasons: 4,
    numberEpisodes: 40,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSerieDetailsModel.toEntity();
    expect(result, tTvSeriesDetail);
  });
}
