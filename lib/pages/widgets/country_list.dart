import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore/pages/controller/country_controller.dart';
import 'package:explore/pages/widgets/country_details.dart';
import 'package:explore/pages/widgets/shimmer.dart';
import 'package:explore/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CountryController.instance;
    return FutureBuilder(
      future: controller.getAllCountry(),
      builder: (context, snapshot) {
        final response = ECloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
        );

        if (response != null) return response;

        controller.filteredCountries = snapshot.data!;

        return Expanded(
          child: Obx(
            () => ListView.separated(
              key: Key(controller.isSearching.toString()),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              itemBuilder: (_, index1) {
                final countryList =
                    controller.groupCountryByAlphabetically(
                      controller.filteredCountries,
                    )[index1];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.letter[index1],
                      style: TextStyle(color: Color(0xFF98A2B3)),
                    ),
                    SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          countryList.length > 5 ? 5 : countryList.length,
                      itemBuilder: (_, index2) {
                        final country = countryList[index2];
                        return InkWell(
                          onTap:
                              () => Get.to(
                                () => CountryDetailsScreen(country: country),
                              ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                  imageUrl:
                                      controller.getValuesFromObject(
                                        country.flag!,
                                      )[0] ??
                                      '',
                                  progressIndicatorBuilder:
                                      (context, url, dowloadProgress) =>
                                          const EShimmerEffect(
                                            width: 40,
                                            height: 40,
                                            radius: 10,
                                          ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country.name!,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    country.capital == null
                                        ? ''
                                        : country.capital![0],
                                    style: TextStyle(color: Color(0xFF667085)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(height: 20);
              },
              itemCount:
                  controller
                      .groupCountryByAlphabetically(
                        controller.filteredCountries,
                      )
                      .length,
            ),
          ),
        );
      },
    );
  }
}
