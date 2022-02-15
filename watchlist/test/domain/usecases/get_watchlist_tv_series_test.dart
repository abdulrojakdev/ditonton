import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockGetWatchlistTvSeries);
  });

  test('should get list of movies from the repository', () async {
    when(mockGetWatchlistTvSeries.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));

    final result = await usecase.execute();

    expect(result, Right(testTvSeriesList));
  });
}
