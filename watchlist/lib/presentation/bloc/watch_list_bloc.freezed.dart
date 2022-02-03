// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'watch_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WatchListStateTearOff {
  const _$WatchListStateTearOff();

  _WatchListState call(
      {RequestState? watchListMovieState,
      List<Movie>? watchListMovie,
      RequestState? watchListTvSeriesState,
      List<TvSeries>? watchListTvSeries,
      String? message}) {
    return _WatchListState(
      watchListMovieState: watchListMovieState,
      watchListMovie: watchListMovie,
      watchListTvSeriesState: watchListTvSeriesState,
      watchListTvSeries: watchListTvSeries,
      message: message,
    );
  }
}

/// @nodoc
const $WatchListState = _$WatchListStateTearOff();

/// @nodoc
mixin _$WatchListState {
  RequestState? get watchListMovieState => throw _privateConstructorUsedError;
  List<Movie>? get watchListMovie => throw _privateConstructorUsedError;
  RequestState? get watchListTvSeriesState =>
      throw _privateConstructorUsedError;
  List<TvSeries>? get watchListTvSeries => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WatchListStateCopyWith<WatchListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchListStateCopyWith<$Res> {
  factory $WatchListStateCopyWith(
          WatchListState value, $Res Function(WatchListState) then) =
      _$WatchListStateCopyWithImpl<$Res>;
  $Res call(
      {RequestState? watchListMovieState,
      List<Movie>? watchListMovie,
      RequestState? watchListTvSeriesState,
      List<TvSeries>? watchListTvSeries,
      String? message});
}

/// @nodoc
class _$WatchListStateCopyWithImpl<$Res>
    implements $WatchListStateCopyWith<$Res> {
  _$WatchListStateCopyWithImpl(this._value, this._then);

  final WatchListState _value;
  // ignore: unused_field
  final $Res Function(WatchListState) _then;

  @override
  $Res call({
    Object? watchListMovieState = freezed,
    Object? watchListMovie = freezed,
    Object? watchListTvSeriesState = freezed,
    Object? watchListTvSeries = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      watchListMovieState: watchListMovieState == freezed
          ? _value.watchListMovieState
          : watchListMovieState // ignore: cast_nullable_to_non_nullable
              as RequestState?,
      watchListMovie: watchListMovie == freezed
          ? _value.watchListMovie
          : watchListMovie // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      watchListTvSeriesState: watchListTvSeriesState == freezed
          ? _value.watchListTvSeriesState
          : watchListTvSeriesState // ignore: cast_nullable_to_non_nullable
              as RequestState?,
      watchListTvSeries: watchListTvSeries == freezed
          ? _value.watchListTvSeries
          : watchListTvSeries // ignore: cast_nullable_to_non_nullable
              as List<TvSeries>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$WatchListStateCopyWith<$Res>
    implements $WatchListStateCopyWith<$Res> {
  factory _$WatchListStateCopyWith(
          _WatchListState value, $Res Function(_WatchListState) then) =
      __$WatchListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {RequestState? watchListMovieState,
      List<Movie>? watchListMovie,
      RequestState? watchListTvSeriesState,
      List<TvSeries>? watchListTvSeries,
      String? message});
}

/// @nodoc
class __$WatchListStateCopyWithImpl<$Res>
    extends _$WatchListStateCopyWithImpl<$Res>
    implements _$WatchListStateCopyWith<$Res> {
  __$WatchListStateCopyWithImpl(
      _WatchListState _value, $Res Function(_WatchListState) _then)
      : super(_value, (v) => _then(v as _WatchListState));

  @override
  _WatchListState get _value => super._value as _WatchListState;

  @override
  $Res call({
    Object? watchListMovieState = freezed,
    Object? watchListMovie = freezed,
    Object? watchListTvSeriesState = freezed,
    Object? watchListTvSeries = freezed,
    Object? message = freezed,
  }) {
    return _then(_WatchListState(
      watchListMovieState: watchListMovieState == freezed
          ? _value.watchListMovieState
          : watchListMovieState // ignore: cast_nullable_to_non_nullable
              as RequestState?,
      watchListMovie: watchListMovie == freezed
          ? _value.watchListMovie
          : watchListMovie // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      watchListTvSeriesState: watchListTvSeriesState == freezed
          ? _value.watchListTvSeriesState
          : watchListTvSeriesState // ignore: cast_nullable_to_non_nullable
              as RequestState?,
      watchListTvSeries: watchListTvSeries == freezed
          ? _value.watchListTvSeries
          : watchListTvSeries // ignore: cast_nullable_to_non_nullable
              as List<TvSeries>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_WatchListState implements _WatchListState {
  const _$_WatchListState(
      {this.watchListMovieState,
      this.watchListMovie,
      this.watchListTvSeriesState,
      this.watchListTvSeries,
      this.message});

  @override
  final RequestState? watchListMovieState;
  @override
  final List<Movie>? watchListMovie;
  @override
  final RequestState? watchListTvSeriesState;
  @override
  final List<TvSeries>? watchListTvSeries;
  @override
  final String? message;

  @override
  String toString() {
    return 'WatchListState(watchListMovieState: $watchListMovieState, watchListMovie: $watchListMovie, watchListTvSeriesState: $watchListTvSeriesState, watchListTvSeries: $watchListTvSeries, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WatchListState &&
            (identical(other.watchListMovieState, watchListMovieState) ||
                const DeepCollectionEquality()
                    .equals(other.watchListMovieState, watchListMovieState)) &&
            (identical(other.watchListMovie, watchListMovie) ||
                const DeepCollectionEquality()
                    .equals(other.watchListMovie, watchListMovie)) &&
            (identical(other.watchListTvSeriesState, watchListTvSeriesState) ||
                const DeepCollectionEquality().equals(
                    other.watchListTvSeriesState, watchListTvSeriesState)) &&
            (identical(other.watchListTvSeries, watchListTvSeries) ||
                const DeepCollectionEquality()
                    .equals(other.watchListTvSeries, watchListTvSeries)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(watchListMovieState) ^
      const DeepCollectionEquality().hash(watchListMovie) ^
      const DeepCollectionEquality().hash(watchListTvSeriesState) ^
      const DeepCollectionEquality().hash(watchListTvSeries) ^
      const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$WatchListStateCopyWith<_WatchListState> get copyWith =>
      __$WatchListStateCopyWithImpl<_WatchListState>(this, _$identity);
}

abstract class _WatchListState implements WatchListState {
  const factory _WatchListState(
      {RequestState? watchListMovieState,
      List<Movie>? watchListMovie,
      RequestState? watchListTvSeriesState,
      List<TvSeries>? watchListTvSeries,
      String? message}) = _$_WatchListState;

  @override
  RequestState? get watchListMovieState => throw _privateConstructorUsedError;
  @override
  List<Movie>? get watchListMovie => throw _privateConstructorUsedError;
  @override
  RequestState? get watchListTvSeriesState =>
      throw _privateConstructorUsedError;
  @override
  List<TvSeries>? get watchListTvSeries => throw _privateConstructorUsedError;
  @override
  String? get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WatchListStateCopyWith<_WatchListState> get copyWith =>
      throw _privateConstructorUsedError;
}
