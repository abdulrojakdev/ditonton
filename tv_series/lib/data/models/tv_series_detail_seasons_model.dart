import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/detail_seasons.dart';

import 'tv_series_episode_model.dart';

class TvSeriesDetailSeasonsModel extends Equatable {
  TvSeriesDetailSeasonsModel({
    required this.id,
    this.episodes,
  });

  final int id;
  final List<TvSeriesEpisodeModel?>? episodes;

  factory TvSeriesDetailSeasonsModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailSeasonsModel(
        id: json["id"],
        episodes: List<TvSeriesEpisodeModel>.from(
          json["episodes"].map(
            (x) => TvSeriesEpisodeModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episodes": List<dynamic>.from(
          episodes!.map(
            (x) => x!.toJson(),
          ),
        ),
      };

  DetailSeasons toEntity() {
    return DetailSeasons(
      id: this.id,
      episodes: this.episodes!.map((episodes) => episodes!.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, episodes];
}
