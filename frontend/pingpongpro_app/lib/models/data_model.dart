class DataAllhits {
  int id;
  final String title;
  final int counter;
  final double tmor;
  final double cra;
  final double tmcr;

  DataAllhits(
      {this.id, this.title, this.counter, this.tmor, this.cra, this.tmcr});

  factory DataAllhits.fromJson(Map<dynamic, dynamic> json) {
    return DataAllhits(
        id: json['id'],
        counter: json['counter'],
        tmor: json['tmor'],
        cra: json['cra'],
        tmcr: json['tmcr']);
  }
  dynamic toJson() => {
        'id': id,
        'title': title,
        'counter': counter,
        'tmor': tmor,
        'cra': cra,
        'tmcr:': tmcr
      };
}
