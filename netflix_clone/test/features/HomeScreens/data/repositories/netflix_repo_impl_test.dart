import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netflix_clone/core/errors/exceptions.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/core/services/network_info.dart';
import 'package:netflix_clone/features/Homescreens/data/datasources/netflix_remote_DS.dart';
import 'package:netflix_clone/features/Homescreens/data/models/NetflixModel.dart';
import 'package:netflix_clone/features/Homescreens/data/repositories/netflix_repository_impl.dart';

class MockRemoteDataSource extends Mock implements NetflixRemoteDS {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NetflixRepoImpl? repository;
  MockRemoteDataSource? mockRemoteDS;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDS = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NetflixRepoImpl(
      remoteDataSource: mockRemoteDS!,
      networkInfo: mockNetworkInfo!,
    );
  });

  const tRuntime = 1;
  const tTitle = 'test';
  const tNetflixModel = NetflixModel(
    title: 'test',
    runtime: tRuntime,
    adult: false,
    overview: 'Lorem Ipsum dolor sit amet.',
    status: 'Released',
  );

  group('getConcreteNetflixMovie:', () {
    test(
      'should check if the device is ONLINE',
      () async {
        // arange
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
        // act
        repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verifyNever(mockNetworkInfo!.isConnected);
      },
    );
  });

  group('device is ONLINE:', () {
    test(
      'should return remote data when the call to remote DS is successful',
      () async {
        // arange
        when(mockRemoteDS!.getConcreteNetflixMovie(tTitle)).thenAnswer((_) async => tNetflixModel);
        // act
        final result = await repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verify(mockRemoteDS!.getConcreteNetflixMovie(tTitle));
        expect(result, equals(const Right(tNetflixModel)));
      },
    );

    test(
      'should throw a ServerFailure when the call to the Remote DS is unsuccessful',
      () async {
        // arange
        when(mockRemoteDS!.getConcreteNetflixMovie(tTitle)).thenThrow(ServerException());
        // act
        final result = await repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verify(mockRemoteDS!.getConcreteNetflixMovie(tTitle));
        verifyNoMoreInteractions(mockRemoteDS);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  // group('device is OFFLINE:', () {
  //   setUp(() {
  //     when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
  //   });
  //   test(
  //     'should return a banner to inform user to connect to the internet',
  //     () async {
  //       // arange

  //       // act
  //       // final result = await repository!.getConcreteNetflixMovie(tTitle);
  //       final result = await NetworkInfo.
  //       // assert
  //       // verifyZeroInteractions(mockRemoteDS);
  //       expect(result, equals(const Right(tNetflixModel)));
  //     },
  //   );
  // });
}
