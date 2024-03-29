part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();
}

class SearchTvSeriesLoading extends SearchTvSeriesState {
  @override
  List<Object?> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {
  @override
  List<Object?> get props => [];
}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  SearchTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvSeriesHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  SearchTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
