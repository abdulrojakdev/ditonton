part of 'tv_series_list_bloc.dart';

abstract class TvSeriesListEvent extends Equatable {}

class FetchNowPlayingTvSeries extends TvSeriesListEvent{
  @override
  List<Object?> get props => [];
}

class FetchPopularTvSeries extends TvSeriesListEvent{
  @override
  List<Object?> get props => [];
}

class FetchTopRatedTvSeries extends TvSeriesListEvent{
  @override
  List<Object?> get props => [];
}
