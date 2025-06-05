import '../data/datasources/insurance_local_datasource.dart';
import '../data/repositories/insurance_repository_impl.dart';
import '../domain/repositories/insurance_repository.dart';
import '../presentation/cubit/insurance_cubit.dart';

class InsuranceService {
  static InsuranceLocalDataSource? _localDataSource;
  static InsuranceRepository? _repository;

  static InsuranceLocalDataSource get localDataSource {
    _localDataSource ??= InsuranceLocalDataSourceImpl();
    return _localDataSource!;
  }

  static InsuranceRepository get repository {
    _repository ??= InsuranceRepositoryImpl(localDataSource: localDataSource);
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