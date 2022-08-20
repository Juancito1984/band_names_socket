class Band {
  final String id;
  final String name;
  final int votes;

  Band({
    this.id = '',
    this.name = '',
    this.votes = 0,
  });

  factory Band.fromMap(Map<String, dynamic> obj) {
    return Band(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes'],
    );
  }
}
