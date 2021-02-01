
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yhwh/classes/AppTheme.dart';

class MainPageController extends GetxController{
  
  int mainPagetabIndex = 0;
  GetStorage getStorage = GetStorage();

  @override
  void onInit() {
    mainPagetabIndex = getStorage.read("mainPagetabIndex") ?? 0;
    super.onInit();
  }

  @override
  void onReady() async {
    Get.changeTheme(AppTheme.getTheme(getStorage.read("currentTheme") ?? 'light'));
    super.onReady();
  }

  void bottomNavigationBarOnTap(int index) async {
    this.mainPagetabIndex = index;
    getStorage.write("mainPagetabIndex", mainPagetabIndex);
    update();
  }

  void buttonOnPress(){
    String newTheme = AppTheme().getRandomTheme();
    
    getStorage.write("currentTheme", newTheme);
    Get.changeTheme(AppTheme.getTheme(newTheme));
  }

}