import '../../domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';
import 'seasons_model.dart';

class TvSeriesDetailModel extends Equatable {
  TvSeriesDetailModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.genres,
    required this.seasons,
    required this.episodeRunTime,
    required this.numberSeasons,
    required this.numberEpisodes,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  final int id;
  final String? name;
  final String? originalName;
  final List<GenreModel> genres;
  final List<SeasonsModel> seasons;
  final List<int> episodeRunTime;
  final int numberSeasons;
  final int numberEpisodes;
  final String overview;
  final String? posterPath;
  final double? voteAverage;

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<SeasonsModel>.from(
            json["seasons"].map((x) => SeasonsModel.fromJson(x))),
        episodeRunTime: List<int>.from(
            json["episode_run_time"].map((x) => x)),
        overview: json["overview"],
        numberSeasons: json["number_of_seasons"],
        numberEpisodes: json["number_of_episodes"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "original_name": originalName,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "episode_run_time": episodeRunTime,
    "number_of_seasons": numberSeasons,
    "number_of_episodes": numberEpisodes,
    "overview": overview,
    "poster_path": posterPath,
    "vote_average": voteAverage,
  };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: this.id,
      name: this.name,
      originalName: this.originalName,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      seasons: this.seasons.map((seasons) => seasons.toEntity()).toList(),
      overview: this.overview,
      episodeRunTime: this.episodeRunTime,
      numberSeasons: this.numberSeasons,
      numberEpisodes: this.numberEpisodes,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    genres,
    seasons,
    overview,
    episodeRunTime,
    numberSeasons,
    numberEpisodes,
    posterPath,
    voteAverage,
  ];
}
