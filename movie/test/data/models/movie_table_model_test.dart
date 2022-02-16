import 'package:movie/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie.dart';

void main() {
  final tMovieTableModel = MovieTable(
    id: 1,
    title: 'Title',
    overview: 'Overview',
    posterPath: '/path.jpg',
  );

  final tMovieTable = Movie.watchlist(
    id: 1,
    title: 'Title',
    overview: 'Overview',
    posterPath: '/path.jpg',
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tMovieTableModel.toEntity();
    expect(result, tMovieTable);
  });
}
