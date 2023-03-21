import 'package:nakatomi_flutter_coding_test/services/container_state_service/container_state.dart';

abstract class IContainerStateService {
  ContainerState getContainerState(double width, double height, int maxLines);
}
