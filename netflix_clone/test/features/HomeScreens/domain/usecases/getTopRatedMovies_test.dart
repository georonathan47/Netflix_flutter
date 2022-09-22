import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netflix_clone/core/usecases/usecase.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/domain/repositories/netflix_repository.dart';
import 'package:netflix_clone/features/Homescreens/domain/usecases/getTopRatedMovies.dart';

class MockNetflixRepository extends Mock implements NetflixRepository {}

void main() {
  GetTopRatedNetflixMovie? usecase;
  MockNetflixRepository? mockNetflixRepository;

  setUp(() {
    mockNetflixRepository = MockNetflixRepository();
    usecase = GetTopRatedNetflixMovie(mockNetflixRepository!);
  });

  const tRuntime = 1;
  const tTitle = 'test';
  const tNetflixMovie = NetflixEntity(title: 'test', runtime: tRuntime);
  test(
    'should get Top Rated movies from the repository',
    () async {
      // arrange
      when(mockNetflixRepository!.getTopRatedNetflixMovies()).thenAnswer((_) async => const Right(tNetflixMovie));
      // act
      final result = await usecase!(NoParams());

      // assert
      expect(result, const Right(tNetflixMovie));
      verify(mockNetflixRepository!.getTopRatedNetflixMovies());
      // verifyNoMoreInteractions(mockNetflixRepository!);
    },
  );
}
