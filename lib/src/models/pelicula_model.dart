class Peliculas {
  List<Pelicula> items = new List();
  Peliculas();

  Peliculas.fromJSONList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJSONMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJSONMap(Map<String, dynamic> jsonResponse) {
    voteCount = jsonResponse['vote_count'];
    id = jsonResponse['id'];
    video = jsonResponse['video'];
    voteAverage = jsonResponse['vote_average'] / 1;
    title = jsonResponse['title'];
    popularity = jsonResponse['popularity'] / 1;
    posterPath = jsonResponse['poster_path'];
    originalLanguage = jsonResponse['original_language'];
    originalTitle = jsonResponse['original_title'];
    genreIds = jsonResponse['genre_ids'].cast<int>();
    backdropPath = jsonResponse['backdrop_path'];
    adult = jsonResponse['adult'];
    overview = jsonResponse['overview'];
    releaseDate = jsonResponse['release_date'];
  }
  getPosterImg() {
    if (posterPath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/f/fc/No_picture_available.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/f/fc/No_picture_available.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
