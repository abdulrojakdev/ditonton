import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/repositories/tv_series_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
