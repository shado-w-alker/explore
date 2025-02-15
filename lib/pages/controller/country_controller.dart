import 'package:explore/pages/model/country_model.dart';
import 'package:explore/repositories/countries_repository.dart';
import 'package:explore/utils/constants/colors.dart';
import 'package:explore/utils/helpers/helper_functions.dart';
import 'package:explore/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  static CountryController get instance => Get.find();

  RxList letter = [].obs;
  List<CountryModel> countries = <CountryModel>[];
  List<CountryModel> filteredCountries = [];
  TextEditingController searchString = TextEditingController();
  RxBool isDark = true.obs;
  RxBool isSearching = false.obs;

  var selectedLanguage = 'eng'.obs;

  void changeLanguage(String langCode) {
    selectedLanguage.value = langCode;
    var locale = Locale(langCode);
    Get.updateLocale(locale);
  }

  Future<List<CountryModel>> getAllCountry() async {
    try {
      final repo = Get.put(CountriesRepository());

      countries = await repo.getAllCountries();

      return countries;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'No Country found', message: e.toString());
      return [];
    }
  }

  void searchCountries(String value) {
    isSearching.value = !isSearching.value;

    filteredCountries =
        countries
            .where(
              (country) =>
                  country.name!.toLowerCase().contains(value.toLowerCase()) ||
                  country.officail!.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
  }

  List<dynamic> getValuesFromObject(Map<String, dynamic> data) {
    List<dynamic> values = [];

    if (data.isEmpty) return values;

    data.forEach((key, value) {
      values.add(value);
    });

    return values;
  }

  List<List<String>> getKeyValueFromObject(List<CountryModel> countries) {
    List<List<String>> keyValues = [];
    Set<String> seen = {};
    List<List<String>> uniqueLists = [];

    if (countries.isEmpty) return keyValues;

    for (var country in countries) {
      country.languages!.forEach((key, value) {
        keyValues.add([key, value]);
      });
    }

    for (var list in keyValues) {
      String key = list.join(
        '|',
      ); // Joined items with a separator to keep index order
      if (!seen.contains(key)) {
        seen.add(key);
        uniqueLists.add(list);
      }
    }

    return uniqueLists;
  }

  List<List<CountryModel>> groupCountryByAlphabetically(
    List<CountryModel> countries,
  ) {
    try {
      Map<String, List<CountryModel>> grouped = {};

      for (var country in countries) {
        String firstLetter = country.name![0].toLowerCase();
        if (grouped.containsKey(firstLetter)) {
          grouped[firstLetter]!.add(country);
        } else {
          grouped[firstLetter] = [country];
        }
      }

      // Sort each group and return as a list of lists
      final sortedKeys = grouped.keys.toList()..sort();
      List<String> letters =
          sortedKeys.map((key) => key.toUpperCase()).toList();
      List<List<CountryModel>> result = [];

      for (var key in sortedKeys) {
        grouped[key]!.sort((a, b) => a.name!.compareTo(b.name!));
        result.add(grouped[key]!);
      }

      letter.value = letters;

      return result;
    } catch (e) {
      return [];
    }
  }

  void showLanguageBottomSheet(BuildContext context) {
    final result = getKeyValueFromObject(countries);

    Get.bottomSheet(
      backgroundColor:
          EHelperFunctions.isDarkMode(context) ? EColors.dark : EColors.light,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children:
                        result.map((r) => r[0]).map((lang) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  changeLanguage(lang);
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getLanguageName(lang)),
                                    Radio<String>(
                                      value: lang,
                                      groupValue: selectedLanguage.value,
                                      onChanged: (value) {
                                        changeLanguage(value!);
                                        Get.back(); // Close bottom sheet
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getLanguageName(String code) {
    final result = getKeyValueFromObject(countries);

    final abbr =
        result
            .where((abb) => abb[0].toLowerCase() == code.toLowerCase())
            .toList();

    return abbr[0][1];
  }
}
