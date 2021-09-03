class Data {
  int id;
  String title;
  int hits;
  double over;
  double under;
  double good;

  Data({
    this.id,
    this.title,
    this.hits,
    this.over,
    this.under,
    this.good,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'],
        title: json['title'],
        hits: json['hits'],
        over: json['over'],
        under: json['under'],
        good: json['good']);
  }
  dynamic toJson() => {
        'id': id,
        'title': title,
        'hits': hits,
        'over': over,
        'under': under,
        'good': good
      };
}
