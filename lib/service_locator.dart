import 'package:get_it/get_it.dart';
import 'package:nakatomi_flutter_coding_test/services/container_state_service/container_state_service.dart';
import 'package:nakatomi_flutter_coding_test/services/container_state_service/i_container_state_service.dart';

GetIt serviceLocator = GetIt.instance;

// register your services here
void initServiceLocator() {
  serviceLocator
      .registerLazySingleton<IContainerStateService>(ContainerStateService.new);
}
