import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/core/errors/exceptions.dart';
import 'package:netflix_clone/core/services/network_info.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/data/models/NetflixModel.dart';
import 'package:netflix_clone/features/Homescreens/data/datasources/netflix_localDS.dart';
import 'package:netflix_clone/features/Homescreens/data/datasources/netflix_remote_DS.dart';
import 'package:netflix_clone/features/Homescreens/data/repositories/netflix_repository_impl.dart';

class MockRemoteDataSource extends Mock implements NetflixRemoteDS {}

class MockLocaleDataSource extends Mock implements NetflixLocaleDS {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NetflixRepoImpl? repository;
  MockRemoteDataSource? mockRemoteDS;
  MockLocaleDataSource? mockLocaleDS;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDS = MockRemoteDataSource();
    mockLocaleDS = MockLocaleDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NetflixRepoImpl(
      remoteDataSource: mockRemoteDS,
      networkInfo: mockNetworkInfo,
      localeDataSource: mockLocaleDS!,
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
  const NetflixEntity tNetflix = tNetflixModel;

  group('getConcreteNetflixMovie:', () {
    test(
      'should check if the device is ONLINE',
      () async {
        // arange
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
        // act
        repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verify(mockNetworkInfo!.isConnected);
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
        verifyNever(mockRemoteDS!.getConcreteNetflixMovie(tTitle));
        expect(result, equals(const Right(tNetflix)));
      },
    );

    test(
      'should cache the data locally when the call to the remote DS is successful',
      () async {
        // arange
        when(mockRemoteDS!.getConcreteNetflixMovie(tTitle)).thenAnswer((_) async => tNetflixModel);
        // act
        await repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verifyNever(mockRemoteDS!.getConcreteNetflixMovie(tTitle));
        verify(mockLocaleDS!.cacheMovie(tNetflixModel));
      },
    );

    test(
      'should return server failure when the call to the remote DS is unsuccessful',
      () async {
        // arange
        when(mockRemoteDS!.getConcreteNetflixMovie(tTitle)).thenThrow(ServerException());
        // act
        final result = await repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verifyNever(mockRemoteDS!.getConcreteNetflixMovie(tTitle));
        verifyZeroInteractions(mockLocaleDS);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('device is OFFLINE:', () {
    setUp(() {
      when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
    });
    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arange
        when(mockLocaleDS!.getLastNetflixMovie()).thenAnswer((_) async => tNetflixModel);
        // act
        final result = await repository!.getConcreteNetflixMovie(tTitle);
        // assert
        verifyZeroInteractions(mockRemoteDS);
        verify(mockLocaleDS!.getLastNetflixMovie());
        expect(result, equals(const Right(tNetflix)));
      },
    );
  });
}
