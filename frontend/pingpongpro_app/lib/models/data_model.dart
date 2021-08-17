class Data {
  final int total;
  final int id;
  final String title;

  Data({
    this.total,
    this.id,
    this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(id: json['id'], title: json['title'], total: json['total']);
  }
}
