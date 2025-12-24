import 'package:get/get.dart';
import '../../../../core/di/grpc_injection.dart';
import '../controllers/exchange_controller.dart';

class ExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(
      () => ExchangeController(
        repository: getExchangeRepository(),
      ),
    );
  }
}
