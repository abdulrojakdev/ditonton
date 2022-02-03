import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesTableModel = TvSeriesTable(
  id: 1,
  name: 'Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
);

  final tTvSeriesTable = TvSeries.watchlist(
    id: 1,
    name: 'Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesTableModel.toEntity();
    expect(result, tTvSeriesTable);
  });
}
