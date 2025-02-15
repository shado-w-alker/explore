import 'package:explore/pages/controller/country_controller.dart';
import 'package:explore/pages/model/country_model.dart';
import 'package:explore/utils/constants/colors.dart';
import 'package:explore/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  // Sample data to filter
  final List<String> dataList = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Pineapple',
    'Grapes',
  ];

  // List of Continents

  @override
  void onInit() {
    filterSections = [
      FilterSection(
        header: 'Continent',
        options: mergeContinents(),
        isExpanded: false,
      ),
      FilterSection(
        header: 'Time Zone',
        options: mergeTimeZones(),
        isExpanded: false,
      ),
    ];

    super.onInit();
  }

  RxBool updateUI = false.obs;

  // Filter options for each section
  List<FilterSection> filterSections = [];

  // List of Continents
  List<String> mergeContinents() {
    final List<String> continents = [];

    List<CountryModel> allCountry = CountryController.instance.countries;

    for (var country in allCountry) {
      for (var i = 0; i < country.continent!.length; i++) {
        continents.add(country.continent![i]);
      }
    }

    List<String> listWithoutDuplicates = continents.toSet().toList();

    return listWithoutDuplicates;
  }

  // List of Time Zones
  List<String> mergeTimeZones() {
    final List<String> timeZone = [];

    List<CountryModel> allCountry = CountryController.instance.countries;

    for (var country in allCountry) {
      for (var i = 0; i < country.timeZone!.length; i++) {
        timeZone.add(country.timeZone![i]);
      }
    }

    List<String> listWithoutDuplicates = timeZone.toSet().toList();

    return listWithoutDuplicates;
  }

  // Selected options
  final selectedOptions = <String>[].obs;

  // Toggle selection of an option
  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }

  // Reset all selections
  void resetSelections() {
    selectedOptions.clear();
    CountryController.instance.filteredCountries =
        CountryController.instance.countries;

    CountryController.instance.isSearching.toggle();

    Get.back();
  }

  // Filter the data list based on selected options
  void showResults() {
    try {
      final filteredList =
          CountryController.instance.countries.where((country) {
            List timeZones = country.timeZone!;
            List continents = country.continent!;

            bool hasTimeZone = false;
            bool hasContinent = false;

            for (var i = 0; i < timeZones.length; i++) {
              hasTimeZone = selectedOptions.contains(timeZones[i]);
            }

            for (var i = 0; i < continents.length; i++) {
              hasContinent = selectedOptions.contains(continents[i]);
            }

            return hasTimeZone || hasContinent;
          }).toList();

      if (filteredList.isEmpty) {
        Get.snackbar(
          'Filtered Results',
          'No results found',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        CountryController.instance.filteredCountries = filteredList;
        CountryController.instance.isSearching.toggle();
      }

      Get.back();
    } catch (e) {
      print(e.toString());
    }
  }

  void showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      backgroundColor:
          EHelperFunctions.isDarkMode(context) ? EColors.dark : EColors.light,

      isScrollControlled: true,
      Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  icon: Icon(Icons.cancel, color: Color(0xFF98A2B3)),
                  onPressed: () {
                    Get.back(); // Close the bottom sheet
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  child: ExpansionPanelList(
                    dividerColor:
                        EHelperFunctions.isDarkMode(context)
                            ? EColors.dark
                            : EColors.light,

                    key: Key(updateUI.toString()),
                    expansionCallback: (int index, bool isExpanded) {
                      // Toggle the expanded state of the section
                      filterSections[index].isExpanded =
                          !filterSections[index].isExpanded;
                      updateUI.toggle();
                    },
                    children:
                        filterSections.map<ExpansionPanel>((
                          FilterSection section,
                        ) {
                          return ExpansionPanel(
                            backgroundColor:
                                EHelperFunctions.isDarkMode(context)
                                    ? EColors.dark
                                    : EColors.light,

                            headerBuilder: (
                              BuildContext context,
                              bool isExpanded,
                            ) {
                              return ListTile(title: Text(section.header));
                            },
                            body: Column(
                              children:
                                  section.options.map((option) {
                                    return CheckboxListTile(
                                      title: Text(option),
                                      value: selectedOptions.contains(option),
                                      onChanged: (bool? value) {
                                        toggleOption(option);
                                      },
                                    );
                                  }).toList(),
                            ),
                            isExpanded:
                                section
                                    .isExpanded, // Use the isExpanded property
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 104,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: resetSelections,
                    child: Center(child: Text('Reset')),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: showResults,
                    child: Text('Show Results'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for each filter section
class FilterSection {
  String header;
  List<String> options;
  bool isExpanded;

  FilterSection({
    required this.header,
    required this.options,
    this.isExpanded = false,
  });
}
