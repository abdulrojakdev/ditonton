import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import '../../movie.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state.popularMoviesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.popularMoviesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(state.popularMovies![index]);
                },
                itemCount: state.popularMovies!.length,
              );
            } else if(state.popularMoviesState == RequestState.Error) {
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
