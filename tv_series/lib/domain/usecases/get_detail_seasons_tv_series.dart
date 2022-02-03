import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/detail_seasons.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetDetailSeasonsTvSeries {
  final TvSeriesRepository repository;

  GetDetailSeasonsTvSeries(this.repository);

  Future<Either<Failure, DetailSeasons?>> execute(int tvId, int seasonNumber) async {
    return await repository.getSeasonsTvSeries(tvId, seasonNumber);
  }
}
