import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/persentation/widgets/tv_series_card_list.dart';
import 'package:watchlist/presentation/bloc/watch_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchListBloc>().add(GetWatchListMovieEvent());
    context.read<WatchListBloc>().add(GetWatchListTvSeriesEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<WatchListBloc, WatchListState>(
                builder: (context, state) {
                  if (state.watchListMovieState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.watchListMovieState == RequestState.Loaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final movie = state.watchListMovie![index];
                        return MovieCard(movie);
                      },
                      itemCount: state.watchListMovie!.length,
                    );
                  } else if (state.watchListMovieState == RequestState.Error) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message!),
                    );
                  }
                  return Container();
                },
              ),
              BlocBuilder<WatchListBloc, WatchListState>(
                builder: (context, state) {
                  if (state.watchListTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.watchListTvSeriesState == RequestState.Loaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tvSeries = state.watchListTvSeries![index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: state.watchListTvSeries!.length,
                    );
                  } else if (state.watchListTvSeriesState == RequestState.Error) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message!),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
