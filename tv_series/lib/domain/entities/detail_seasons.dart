import '../../domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class DetailSeasons extends Equatable {
  DetailSeasons({
    required this.id,
    this.episodes,
  });

  final int id;
  final List<Episode?>? episodes;

  @override
  List<Object?> get props => [id, episodes];
}