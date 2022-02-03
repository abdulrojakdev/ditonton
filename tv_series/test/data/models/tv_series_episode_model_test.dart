import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeTvSeriesModel = TvSeriesEpisodeModel(
    id: 557,
    name: 'Cobra Kai',
    overview:
    'his Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
    stillPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    episodeNumber: 1,
  );

  final tEpisodeTvSeries = Episode(
    id: 557,
    name: 'Cobra Kai',
    overview:
    'his Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
    stillPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    episodeNumber: 1,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tEpisodeTvSeriesModel.toEntity();
    expect(result, tEpisodeTvSeries);
  });
}
