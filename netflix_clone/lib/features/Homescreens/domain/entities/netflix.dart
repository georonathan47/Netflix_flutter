import 'package:equatable/equatable.dart';

class NetflixEntity extends Equatable {
  final String title;
  final int runtime;
  final String overview;
  final bool adult;
  final String status;

  const NetflixEntity({
    required this.title,
    required this.runtime,
    required this.adult,
    required this.overview,
    required this.status,
  });

  @override
  List<Object?> get props => [title, runtime];
}
