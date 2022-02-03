import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final tTvSeriesTableModel = TvSeriesTable(
    id: 1,
    name: 'Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
  );

  group('fromEntity', () {
    test('should return a valid model from JSON', () async {
      // arrange
      // act
      final result = TvSeriesTable.fromEntity(testTvSeriesDetail);
      // assert
      expect(result, tTvSeriesTableModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tTvSeriesTableModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Name",
        "overview": "Overview",
        "posterPath": "/path.jpg"
      };
      expect(result, expectedJsonMap);
    });
  });
}
