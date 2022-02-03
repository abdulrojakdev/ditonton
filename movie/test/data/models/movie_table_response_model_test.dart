import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tMovieTableModel = MovieTable(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  group('fromEntity', () {
    test('should return a valid model from JSON', () async {
      // arrange
      // act
      final result = MovieTable.fromEntity(testMovieDetail);
      // assert
      expect(result, tMovieTableModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tMovieTableModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "overview": 'overview',
        "posterPath": 'posterPath',
        "title": 'title',
      };
      expect(result, expectedJsonMap);
    });
  });
}
