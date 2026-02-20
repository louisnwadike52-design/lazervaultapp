import 'package:get/get.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../domain/exchange_feature_config.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import '../controllers/exchange_controller.dart';

class ExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(
      () => ExchangeController(
        repository: serviceLocator<IExchangeRepository>(),
        featureConfig: serviceLocator<ExchangeFeatureConfig>(),
      ),
    );
  }
}
