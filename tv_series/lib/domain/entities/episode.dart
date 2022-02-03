import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, episodeNumber, overview, stillPath];
}