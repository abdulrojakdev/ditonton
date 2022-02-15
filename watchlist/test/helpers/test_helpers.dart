import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main(){}