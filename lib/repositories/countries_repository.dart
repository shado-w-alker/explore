import 'package:explore/pages/model/country_model.dart';
import 'package:explore/utils/http/http_client.dart';
import 'package:get/get.dart';

class CountriesRepository extends GetxController {
  static CountriesRepository get instance => Get.find();

  /// -- Get All Countires
  Future<List<CountryModel>> getAllCountries() async {
    try {
      final data = await EHttpHelper.get();

      final result = data.map((d) => CountryModel.fromMap(d)).toList();

      return result;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }
}
