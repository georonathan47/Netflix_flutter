import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/features/Homescreens/data/models/NetflixModel.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNetflixModel = NetflixModel(
    title: 'Test Title',
    runtime: 150,
    status: 'Released',
    adult: false,
    overview: 'Lorem Ipsum dolor sit amet.',
  );
  test(
    'should be a subclass of the Netflix Entity',
    () async {
      // assert
      expect(tNetflixModel, isA<NetflixEntity>());
    },
  );

  group('fromJSON', () {
    test(
      'should return a valid model when the JSON runtime is an int',
      () async {
        // arange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('netflix'));
        // act
        final result = NetflixModel.fromJson(jsonMap);
        // assert
        expect(result, tNetflixModel);
      },
    );

    test(
      'should return a valid model when the JSON runtime is a double',
      () async {
        // arange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('netflix_double'));
        // act
        final result = NetflixModel.fromJson(jsonMap);
        // assert
        expect(result, tNetflixModel);
      },
    );
  });

  group('toJSON', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arange

        // act
        final result = tNetflixModel.toJson();
        // assert
        final expectedJsonMap = {
          'title': 'Test Title',
          'status': 'Released',
          'runtime': 150,
          'overview': 'Lorem Ipsum dolor sit amet.',
          'adult': false,
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
