import 'package:get_it/get_it.dart';
import '../data/datasources/insurance_local_datasource.dart';
import '../data/datasources/insurance_remote_datasource.dart';
import '../data/repositories/insurance_repository_impl.dart';
import '../domain/repositories/insurance_repository.dart';
import '../presentation/cubit/insurance_cubit.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../core/network/grpc_client.dart';

class InsuranceService {
  static final _serviceLocator = GetIt.instance;

  static InsuranceLocalDataSource? _localDataSource;
  static InsuranceRemoteDataSource? _remoteDataSource;
  static InsuranceRepository? _repository;

  static InsuranceLocalDataSource get localDataSource {
    _localDataSource ??= InsuranceLocalDataSourceImpl();
    return _localDataSource!;
  }

  static InsuranceRemoteDataSource get remoteDataSource {
    _remoteDataSource ??= InsuranceRemoteDataSourceImpl(
      grpcClient: _serviceLocator<GrpcClient>(),
    );
    return _remoteDataSource!;
  }

  static InsuranceRepository get repository {
    _repository ??= InsuranceRepositoryImpl(
      remoteDataSource: remoteDataSource,
      secureStorage: _serviceLocator<SecureStorageService>(),
    );
    return _repository!;
  }

  static InsuranceCubit getCubit(String userId) {
    return InsuranceCubit(
      repository: repository,
    );
  }

  static Future<void> initialize() async {
    await localDataSource.initializeHive();
  }
}
