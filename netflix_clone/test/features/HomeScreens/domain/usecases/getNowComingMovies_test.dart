import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netflix_clone/core/usecases/usecase.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/domain/repositories/netflix_repository.dart';
import 'package:netflix_clone/features/Homescreens/domain/usecases/getNowComingMovies.dart';

class MockNetflixRepository extends Mock implements NetflixRepository {}

void main() {
  GetNowPlayingNetflixMovie? usecase;
  MockNetflixRepository? mockNetflixRepository;

  setUp(() {
    mockNetflixRepository = MockNetflixRepository();
    usecase = GetNowPlayingNetflixMovie(mockNetflixRepository!);
  });

  const tRuntime = 1;
  const tTitle = 'test';
  const tNetflixMovie = NetflixEntity(title: 'test', runtime: tRuntime);
  test(
    'should get Now Playing movies from the repository',
    () async {
      // arrange
      when(mockNetflixRepository!.getNowPlayingNetflixMovies()).thenAnswer((_) async => const Right(tNetflixMovie));
      // act
      final result = await usecase!(NoParams());

      // assert
      expect(result, const Right(tNetflixMovie));
      verify(mockNetflixRepository!.getNowPlayingNetflixMovies());
      // verifyNoMoreInteractions(mockNetflixRepository!);
    },
  );
}
