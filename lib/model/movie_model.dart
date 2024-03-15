// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    @JsonKey(name: "adult") bool? adult,
    @JsonKey(name: "backdrop_path") String? backdropPath,
    @JsonKey(name: "poster_path") String? posterPath,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "original_title") String? originalTitle,
    @JsonKey(name: "overview") String? overview,
    @JsonKey(name: "release_date") String? releaseDate,
    @JsonKey(name: "vote_average") double? voteAverage,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
