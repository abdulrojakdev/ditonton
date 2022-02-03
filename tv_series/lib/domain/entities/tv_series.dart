import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  TvSeries({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  TvSeries.watchlist({
    required this.id,
    required this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.voteAverage,
  });

  final int id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    overview,
    posterPath,
    voteAverage,
  ];
}
