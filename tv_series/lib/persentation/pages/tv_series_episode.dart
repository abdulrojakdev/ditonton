import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/persentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv_series/persentation/widgets/episode_tv_series_card.dart';

class TvSeriesEpisode extends StatefulWidget {
  final int idTv;
  final int seasonNumber;

  const TvSeriesEpisode({
    Key? key,
    required this.idTv,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  _TvSeriesEpisodeState createState() => _TvSeriesEpisodeState();
}

class _TvSeriesEpisodeState extends State<TvSeriesEpisode> {
  @override
  void initState() {
    super.initState();
    context.read<DetailTvSeriesBloc>().add(FetchEpisodeTvSeriesEvent(widget.idTv, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
          builder: (context, state) {
            if (state.tvSeriesSeasonsState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.tvSeriesSeasonsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episodes = state.tvSeriesSeasons!.episodes![index];
                  return EpisodeTvSeriesCard(episodes!);
                },
                itemCount: state.tvSeriesSeasons!.episodes!.length,
              );
            } else if(state.tvSeriesSeasonsState == RequestState.Error) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message!),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
