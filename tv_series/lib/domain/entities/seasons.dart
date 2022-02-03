import 'package:equatable/equatable.dart';

class Seasons extends Equatable {
  Seasons({
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

  @override
  List<Object?> get props => [id, name, posterPath, episodeCount, seasonNumber, airDate];
}
