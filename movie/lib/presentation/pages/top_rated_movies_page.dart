import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../movie.dart';

class TopRatedMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state.topRatedMoviesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedMoviesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(state.topRatedMovies![index]);
                },
                itemCount: state.topRatedMovies!.length,
              );
            } else if (state.topRatedMoviesState == RequestState.Error) {
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
