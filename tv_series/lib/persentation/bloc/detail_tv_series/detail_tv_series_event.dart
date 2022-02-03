part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();
}

class FetchTvSeriesDetailEvent extends DetailTvSeriesEvent {
  final int id;

  FetchTvSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [id];

}

class FetchEpisodeTvSeriesEvent extends DetailTvSeriesEvent {
  final int idTv;
  final int seasonNumber;

  FetchEpisodeTvSeriesEvent(this.idTv, this.seasonNumber);

  @override
  List<Object?> get props => [idTv, seasonNumber];

}

class LoadWatchlistStatusEvent extends DetailTvSeriesEvent {
  final int id;

  LoadWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];

}

class RemoveWatchListTvSeries extends DetailTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  RemoveWatchListTvSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];

}

class AddWatchListTvSeries extends DetailTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  AddWatchListTvSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];

}
