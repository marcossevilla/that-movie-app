class Cast {
  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  // * for the actor detail
  String birthDate;
  String biography;
  double popularity;
  String placeOfBirth;
  String knownForDepartment;

  Actor({
    castId,
    character,
    creditId,
    gender,
    id,
    name,
    order,
    profilePath,
    birthDate,
    biography,
    popularity,
    placeOfBirth,
    knownForDepartment,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
    birthDate = json['birthday'];
    biography = json['biography'];
    popularity = json['popularity'];
    placeOfBirth = json['placeOfBirth'];
    knownForDepartment = json['knownForDepartment'];
  }

  getPicture() {
    if (profilePath == null) {
      return 'https://www.confcommerciomolise.it/wp-content/uploads/2018/02/user-icon.png';
    } else {
      return 'https://image.tmdb.org/t/p/w1280/$profilePath';
    }
  }
}
