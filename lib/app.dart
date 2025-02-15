import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:explore/pages/controller/country_controller.dart';
import 'package:explore/pages/widgets/country_list.dart';
import 'package:explore/pages/widgets/filter_options.dart';
import 'package:explore/utils/constants/image_strings.dart';
import 'package:explore/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountryController());

    return Obx(
      () => GetMaterialApp(
        title: 'Explore',
        themeMode: controller.isDark.value ? ThemeMode.dark : ThemeMode.light,
        theme: EAppTheme.lightTheme,
        darkTheme: EAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.isDark.value
                        ? Image.asset(EImages.darkAppLogo)
                        : Image.asset(EImages.lightAppLogo),
                    InkWell(
                      onTap: () {
                        controller.isDark.toggle();
                      },
                      child:
                          controller.isDark.value
                              ? Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color(0x3398A2B3),
                                ),
                                child: Icon(Iconsax.moon),
                              )
                              : Icon(Icons.sunny),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.searchString,
                  onChanged: (value) => controller.searchCountries(value),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.search),
                    ),
                    hintText: 'Search Country',
                    filled: true,
                    fillColor: Color(0x3398A2B3),
                  ),
                ),
                SizedBox(height: 16),
                FilterOptions(),
                SizedBox(height: 16),
                CountryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
