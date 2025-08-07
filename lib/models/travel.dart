import 'package:json_annotation/json_annotation.dart';

part 'travel.g.dart';

@JsonSerializable()
class Travel {
  final String id;
  final String title;
  final String country;
  final String region;
  final String startDate;
  final String endDate;
  final String category;
  final String description;
  bool isFavorite;
  final String imagePath;

  Travel({
    required this.id,
    required this.title,
    required this.country,
    required this.region,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.description,
    this.isFavorite = false,
    required this.imagePath,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => _$TravelFromJson(json);
  Map<String, dynamic> toJson() => _$TravelToJson(this);

  Travel copyWith({
    String? id,
    String? title,
    String? country,
    String? region,
    String? startDate,
    String? endDate,
    String? category,
    String? description,
    bool? isFavorite,
    String? imagePath,
  }) {
    return Travel(
      id: id ?? this.id,
      title: title ?? this.title,
      country: country ?? this.country,
      region: region ?? this.region,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
