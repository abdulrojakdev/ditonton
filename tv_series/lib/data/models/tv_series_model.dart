import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

class TvSeriesModel extends Equatable {
  TvSeriesModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  final int id;
  final String? name;
  final String? originalName;
  final String overview;
  final String? posterPath;
  final double? voteAverage;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "vote_average": voteAverage,
  };

  TvSeries toEntity() {
    return TvSeries(
      id: this.id,
      name: this.name,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
    );
  }

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
