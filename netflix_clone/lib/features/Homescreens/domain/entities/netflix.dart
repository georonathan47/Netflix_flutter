import 'package:equatable/equatable.dart';

class NetflixEntity extends Equatable {
  final String title;
  final int runtime;

  const NetflixEntity({required this.title, required this.runtime});

  @override
  List<Object?> get props => [title, runtime];
}
