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

  Actor({
    castId,
    character,
    creditId,
    gender,
    id,
    name,
    order,
    profilePath,
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
  }

  getPicture() {
    if (profilePath == null) {
      return 'https://www.confcommerciomolise.it/wp-content/uploads/2018/02/user-icon.png';
    } else {
      return 'https://image.tmdb.org/t/p/w1280/$profilePath';
    }
  }
}
