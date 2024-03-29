import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/detail_seasons.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail TvSeries);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail TvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
  Future<Either<Failure, DetailSeasons>> getSeasonsTvSeries(int tvId, int seasonNumber);
}
