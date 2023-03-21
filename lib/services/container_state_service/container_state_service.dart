import 'package:nakatomi_flutter_coding_test/services/container_state_service/container_state.dart';
import 'package:nakatomi_flutter_coding_test/services/container_state_service/i_container_state_service.dart';

// All container state related logic here.
class ContainerStateService implements IContainerStateService {
  // this is based of requirements in the notion tickets
  @override
  ContainerState getContainerState(double width, double height, int maxLines) {
    if (width == 72 && maxLines == 1) {
      return ContainerState.one;
    }
    if (width == 72 && maxLines > 1) {
      return ContainerState.two;
    }

    if (width == 90 && maxLines > 1 && maxLines <= 3) {
      return ContainerState.three;
    }

    if (height == 90 && maxLines > 3) {
      return ContainerState.four;
    }
    return ContainerState.none;
  }
}
