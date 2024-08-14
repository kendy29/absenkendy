import 'package:get/get.dart';
import '../../../../models/absen/absen_all_model.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../provider/provider_history_admin.dart';

class HistoryAdminController extends GetxController {
  HistoryAdminProvider provider = HistoryAdminProvider();
  RxList<AllAbsenModel>? data = <AllAbsenModel>[].obs;
  DashboardController dashboardController = Get.put(DashboardController());
  RxBool isLoading = false.obs;
  Future getUserAbsen() async {
    try {
      isLoading.value = true;
      final dataUser = await provider.getAbsenAll(
          brear: dashboardController.brear.value);
      data?.value = dataUser!.data;
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
    Get.delete<HistoryAdminController>();
    HistoryAdminController().dispose();
    super.dispose();
  }
}
