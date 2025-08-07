part of 'travel.dart';

Travel _$TravelFromJson(Map<String, dynamic> json) => Travel(
      id: json['id'] as String,
      title: json['title'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$TravelToJson(Travel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'country': instance.country,
      'region': instance.region,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'category': instance.category,
      'description': instance.description,
      'isFavorite': instance.isFavorite,
      'imagePath': instance.imagePath,
    };
