import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/episode.dart';

class TvSeriesEpisodeModel extends Equatable {
  TvSeriesEpisodeModel({
    required this.id,
    this.name,
    this.episodeNumber,
    this.overview,
    this.stillPath,
  });

  final int id;
  final String? name;
  final int? episodeNumber;
  final String? overview;
  final String? stillPath;

  factory TvSeriesEpisodeModel.fromJson(Map<String, dynamic> json) => TvSeriesEpisodeModel(
    id: json["id"],
    name: json["name"],
    episodeNumber: json["episode_number"],
    overview: json["overview"],
    stillPath: json["still_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "episode_number": episodeNumber,
    "overview": overview,
    "still_path": stillPath,
  };

  Episode toEntity() {
    return Episode(
      id: this.id,
      name: this.name!,
      episodeNumber: episodeNumber!,
      overview: overview!,
      stillPath: stillPath,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, episodeNumber, overview, stillPath];
}
