import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/persentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:tv_series/persentation/widgets/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
          builder: (context, state) {
            if (state.topRatedTvSeriesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedTvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCard(state.topRatedTvSeries![index]);
                },
                itemCount: state.topRatedTvSeries!.length,
              );
            } else if (state.topRatedTvSeriesState == RequestState.Error) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message ?? ""),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
