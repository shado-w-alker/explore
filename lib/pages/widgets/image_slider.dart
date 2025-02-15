import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore/pages/controller/image_slider_controller.dart';
import 'package:explore/pages/model/country_model.dart';
import 'package:explore/pages/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key, required this.country});

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    final ImageSliderController controller = Get.put(ImageSliderController());

    final List<String> imgList = [
      country.flag!['png'] ?? '',
      country.coatOfArm!['png'] ?? '',
      country.map!['openStreetMaps'] ?? '',
    ];

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              items:
                  imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,

                            imageUrl: imgUrl,
                            progressIndicatorBuilder:
                                (context, url, dowloadProgress) =>
                                    const EShimmerEffect(
                                      width: double.infinity,
                                      height: 200,
                                      radius: 10,
                                    ),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                        );
                      },
                    );
                  }).toList(),
              carouselController: controller.carouselController,
              options: CarouselOptions(
                height: 200,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  controller.updateCurrentIndex(index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0x4DF2F4F7),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffFCFCFD),
                        size: 10,
                      ),
                      onPressed: () {
                        controller.goToPreviousPage();
                      },
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0x4DF2F4F7),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xffFCFCFD),
                        size: 10,
                      ),
                      onPressed: () {
                        controller.goToNextPage();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => Positioned(
                bottom: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 2.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                controller.currentIndex.value == index
                                    ? Color(0xffEAECF0)
                                    : Color(0xff999999),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
