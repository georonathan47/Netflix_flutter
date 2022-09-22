// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/domain/repositories/netflix_repository.dart';
import 'package:netflix_clone/features/Homescreens/domain/usecases/getConcreteNetflixMovie.dart';

class MockNetflixRepository extends Mock implements NetflixRepository {}

void main() {
  GetConcreteNetflixMovie? usecase;
  MockNetflixRepository? mockNetflixRepository;

  setUp(() {
    mockNetflixRepository = MockNetflixRepository();
    usecase = GetConcreteNetflixMovie(mockNetflixRepository!);
  });

  const tRuntime = 1;
  const tTitle = 'test';
  const tNetflixMovie = NetflixEntity(title: 'test', runtime: tRuntime);
  test(
    'should get movie for the title from the repository',
    () async {
      // arrange
      when(mockNetflixRepository!.getConcreteNetflixMovie(tTitle)).thenAnswer((_) async => const Right(tNetflixMovie));
      // act
      final result = await usecase!.execute(title: tTitle);
      expect(result, const Right(tNetflixMovie));
      // assert
      // verifyNoMoreInteractions(mockNetflixRepository!);

    },
  );
}
