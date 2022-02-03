import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/episode.dart';

class EpisodeTvSeriesCard extends StatelessWidget {
  final Episode episode;

  EpisodeTvSeriesCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            SizedBox(width: 15.0,),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          episode.episodeNumber.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kSubtitle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: Text(
                            episode.name ?? "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kSubtitle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      episode.overview == "" ? "-" : episode.overview!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}