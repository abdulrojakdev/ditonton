import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/persentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:tv_series/tv_series.dart';

class HomeTvSeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.noPlayingTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.noPlayingTvSeriesState ==
                      RequestState.Loaded) {
                    return TvSeriesList(state.noPlayingTvSeries!);
                  } else if (state.noPlayingTvSeriesState ==
                      RequestState.Error) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message ?? ""),
                    );
                  }
                  return Container();
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TV_SERIES_ROUTE),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.popularTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.popularTvSeriesState ==
                      RequestState.Loaded) {
                    return TvSeriesList(state.popularTvSeries!);
                  } else if (state.popularTvSeriesState == RequestState.Error) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message ?? ""),
                    );
                  }
                  return Container();
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_TV_SERIES_ROUTE),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.topRatedTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.topRatedTvSeriesState ==
                      RequestState.Loaded) {
                    return TvSeriesList(state.topRatedTvSeries!);
                  } else if (state.topRatedTvSeriesState ==
                      RequestState.Error) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message ?? ""),
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                print(tv.id);
                Navigator.pushNamed(
                  context,
                  TV_SERIES_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
