part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
}

class QueryChangedTvSeries extends SearchTvSeriesEvent {
  final String query;

  QueryChangedTvSeries(this.query);

  @override
  List<Object> get props => [query];
}