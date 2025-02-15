import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class ImageSliderController extends GetxController {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RxInt currentIndex = 0.obs;

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void goToPreviousPage() {
    carouselController.previousPage();
  }

  void goToNextPage() {
    carouselController.nextPage();
  }
}
