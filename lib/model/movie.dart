enum Category{
  foryou,
  following,
  papular,
  live,
}


class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.movieactorurl,
    required this.movieimageurl,
    required this.rewies,
    required this.category,
    required this.views,
  });

  final String id;
  final String title;
  final String movieimageurl;
  final String movieactorurl;
  final List<String> description;
  final String duration;
  final String views;
final Category category;
  final String rewies;
}
