class GadgetData {
  final String? color;
  final String? capacity;

  GadgetData({
    this.color,
    this.capacity,
  });

  factory GadgetData.fromJson(Map<String, dynamic>? json) {
    return GadgetData(
      color: json?['color'],
      capacity: json?['Capacity'],
    );
  }
}
