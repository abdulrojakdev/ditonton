import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailSeasonsTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetDetailSeasonsTvSeries(mockTvSeriesRepository);
  });

  final tId = 77169;
  final tSeasonNumber = 1;

  test('should get seasons tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getSeasonsTvSeries(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testSeasonsTvSeries));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(testSeasonsTvSeries));
  });
}
