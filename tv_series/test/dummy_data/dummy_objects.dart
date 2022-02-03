
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/detail_seasons.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/seasons.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  id: 557,
  name: 'Cobra Kai',
  originalName: 'Cobra Kai',
  overview:
      'his Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
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

final testSeasonsTvSeries = DetailSeasons(
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

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'Name',
  'overview': 'Overview',
  'posterPath': '/path.jpg',
};
