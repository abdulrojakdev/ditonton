import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../../search.dart';

part 'search_tv_series_event.dart';

part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<QueryChangedTvSeries>(
      (event, emit) async {
        emit(SearchTvSeriesLoading());

        final result = await _searchTvSeries.execute(event.query);

        result.fold(
          (failure) {
            emit(SearchTvSeriesError(failure.message));
          },
          (data) {
            emit(SearchTvSeriesHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(
          milliseconds: 500,
        ),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
