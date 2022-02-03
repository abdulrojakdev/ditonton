import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/seasons.dart';

class SeasonsModel extends Equatable {
  SeasonsModel({
    required this.id,
    this.name,
    this.posterPath,
    this.episodeCount,
    this.seasonNumber,
    this.airDate,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final int? episodeCount;
  final int? seasonNumber;
  final String? airDate;

  factory SeasonsModel.fromJson(Map<String, dynamic> json) => SeasonsModel(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        episodeCount: json["episode_count"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "episode_count": episodeCount,
        "season_number": seasonNumber,
        "air_date": airDate,
      };

  Seasons toEntity() {
    return Seasons(
      id: this.id,
      name: this.name,
      posterPath: posterPath,
      episodeCount: episodeCount,
      airDate: airDate,
      seasonNumber: seasonNumber,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, episodeCount, seasonNumber, airDate];
}
