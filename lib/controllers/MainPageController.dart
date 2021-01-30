import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yhwh/classes/AppTheme.dart';

class MainPageController extends GetxController{
  
  int mainPagetabIndex = 0;

  @override
  void onInit() {
    mainPagetabIndex = GetStorage().read("mainPagetabIndex") ?? 0;
    super.onInit();
  }

  @override
  void onReady() {
    Get.changeTheme(AppTheme().getTheme(GetStorage().read("currentTheme") ?? 'light'));
    super.onReady();
  }

  void bottomNavigationBarOnTap(int index){
    this.mainPagetabIndex = index;
    GetStorage().write("mainPagetabIndex", mainPagetabIndex);
    update();
  }

  void buttonOnPress(){
    String newTheme = AppTheme().getRandomTheme();
    
    GetStorage().write("currentTheme", newTheme);
    Get.changeTheme(AppTheme().getTheme(newTheme));
  }

}