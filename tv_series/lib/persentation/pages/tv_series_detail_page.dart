import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/persentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv_series/persentation/pages/tv_series_episode.dart';
import 'package:tv_series/tv_series.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;

  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailTvSeriesBloc>().add(FetchTvSeriesDetailEvent(widget.id));
    context.read<DetailTvSeriesBloc>().add(LoadWatchlistStatusEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailTvSeriesBloc, DetailTvSeriesState>(
        listenWhen: (oldState, newState) => oldState.watchlistMessage != newState.watchlistMessage && newState.watchlistMessage != '',
        listener: (context, state) {
          if (state.watchlistMessage ==
              DetailTvSeriesBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  DetailTvSeriesBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.watchlistMessage!),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.tvSeriesDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvSeriesDetailState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContent(
                state.tvSeriesDetail!,
                state.isAddedToWatchlist!,
              ),
            );
          } else if(state.tvSeriesDetailState == RequestState.Error) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message!),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final bool isAddedWatchlist;

  DetailContent(this.tvSeries, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tvSeries.name ?? "-",
                                    style: kHeading5,
                                  ),
                                ),
                                Text(
                                  tvSeries.numberSeasons.toString() +
                                      " Seasons",
                                  // style: kSubtitle,
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 15,
                                  width: 1.5,
                                ),
                                Text(
                                  tvSeries.numberEpisodes.toString() +
                                      " Episode",
                                  // style: kSubtitle,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (isAddedWatchlist == false) {
                                  context
                                      .read<DetailTvSeriesBloc>()
                                      .add(AddWatchListTvSeries(tvSeries));
                                } else {
                                  context
                                      .read<DetailTvSeriesBloc>()
                                      .add(RemoveWatchListTvSeries(tvSeries));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist == true
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Text(
                              _showDuration(tvSeries.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview == ""
                                  ? "No Overview"
                                  : tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final seasons = tvSeries.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TvSeriesEpisode(
                                              idTv: tvSeries.id,
                                              seasonNumber:
                                                  seasons.seasonNumber!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${seasons.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SizedBox(
                                                width: 100,
                                                child: Icon(
                                                  Icons.broken_image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                seasons.name ?? "-",
                                                style: kSubtitle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    seasons.airDate ?? "-",
                                                    style: kBodyText.copyWith(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    height: 11,
                                                    width: 1.5,
                                                  ),
                                                  Text(
                                                    seasons.episodeCount
                                                            .toString() +
                                                        " Episode",
                                                    style: kBodyText.copyWith(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: tvSeries.seasons.length,
                              ),
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _RecommendationsTvSeries()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> runtime) {
    int result = 0;
    for (var time in runtime) {
      result += time;
    }

    final int hours = result ~/ 60;
    final int minutes = result % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class _RecommendationsTvSeries extends StatelessWidget {
  _RecommendationsTvSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.tvSeriesRecommendationsState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.tvSeriesRecommendationsState == RequestState.Error) {
          return Center(
            key: Key('error_message'),
            child: Text(state.message ?? ""),
          );
        } else if (state.tvSeriesRecommendationsState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: state.tvSeriesRecommendations!.length == 0 ? Text("No Recommendations Tv Series") : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeriesRecommendations![index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MOVIE_DETAIL_ROUTE,
                        arguments: tvSeries.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.tvSeriesRecommendations!.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
