import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/persentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:tv_series/persentation/widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
          builder: (context, state) {
            if (state.popularTvSeriesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.popularTvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCard(state.popularTvSeries![index]);
                },
                itemCount: state.popularTvSeries!.length,
              );
            } else if (state.popularTvSeriesState == RequestState.Error) {
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
