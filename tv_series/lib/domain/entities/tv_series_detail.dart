import '../../domain/entities/genre.dart';
import '../../domain/entities/seasons.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.id,
    required this.name,
    required this.originalName,
    required this.genres,
    required this.seasons,
    required this.episodeRunTime,
    required this.numberEpisodes,
    required this.numberSeasons,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  final int id;
  final String? name;
  final String? originalName;
  final List<Genre> genres;
  final List<Seasons> seasons;
  final List<int> episodeRunTime;
  final int numberSeasons;
  final int numberEpisodes;
  final String overview;
  final String? posterPath;
  final double? voteAverage;

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    genres,
    seasons,
    episodeRunTime,
    numberSeasons,
    numberEpisodes,
    overview,
    posterPath,
    voteAverage,
  ];
}
