import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';

class NetflixModel extends NetflixEntity {
  const NetflixModel({
    required String title,
    required int runtime,
    required bool adult,
    required String overview,
    required String status,
  }) : super(
          runtime: runtime,
          title: title,
          overview: overview,
          adult: adult,
          status: status,
        );

  factory NetflixModel.fromJson(Map<String, dynamic> json) => NetflixModel(
        adult: json['adult'],
        overview: json['overview'],
        runtime: (json['runtime'] as num).toInt(),
        status: json['status'],
        title: json['title'],
      );

   Map<String, dynamic> toJson() => {
        'adult': adult,
        'overview': overview,
        'runtime': runtime,
        'status': status,
        'title': title,
      };
}
