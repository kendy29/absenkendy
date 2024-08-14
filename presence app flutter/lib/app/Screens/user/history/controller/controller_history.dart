import 'package:get/get.dart';

import '../../../../models/absen/get_absen_user.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../provider/provider_history_absen.dart';

class HistoryController extends GetxController {
  HistoryAbsenProvider provider = HistoryAbsenProvider();
  RxList<ModelGetUser>? data = <ModelGetUser>[].obs;
  DashboardController dashboardController = Get.put(DashboardController());
  RxBool isLoading = false.obs;
  Future getUserAbsen() async {
    try {
      isLoading.value = true;
      final dataUser = await provider.getAbsenUser(
          identityId: dashboardController.identityId.value,
          brear: dashboardController.brear.value);
      data?.value = dataUser!.data!;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    isLoading.value = false;
    getUserAbsen();
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<HistoryController>();
    HistoryController().dispose();
    super.dispose();
  }
}
