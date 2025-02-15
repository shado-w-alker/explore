import 'package:explore/pages/controller/country_controller.dart';
import 'package:explore/pages/model/country_model.dart';
import 'package:explore/pages/widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({super.key, required this.country});

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          country.name!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ImageSlider(country: country),
              Column(
                children: [
                  CountrySingleDetail(
                    title: 'Population',
                    value:
                        NumberFormat(
                          '#,##0',
                        ).format(country.population).toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Region',
                    value: country.region.toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Capital',
                    value: country.capital![0].toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(title: 'Motto', value: ''),
                ],
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  CountrySingleDetail(
                    title: 'Official Language',
                    value:
                        CountryController.instance
                            .getValuesFromObject(country.languages!)[0]
                            .toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(title: 'Ethic group', value: ''),
                  SizedBox(height: 2),
                  CountrySingleDetail(title: 'Religion', value: ''),
                  SizedBox(height: 2),
                  CountrySingleDetail(title: 'Government', value: ''),
                ],
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  CountrySingleDetail(title: 'Independence', value: ''),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Area',
                    value: '${country.area.toString()} km²',
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Currency',
                    value:
                        CountryController.instance
                            .getValuesFromObject(country.currency!)[0]['name']
                            .toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(title: 'GDP', value: ''),
                ],
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  CountrySingleDetail(
                    title: 'Time Zone',
                    value: country.timeZone!.join(', ').toString(),
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Date Formate',
                    value: 'dd/mm/yyyy',
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Dailling code',
                    value:
                        '${country.diallingCode!['root']}${country.diallingCode!['suffixes'][0]}',
                  ),
                  SizedBox(height: 2),
                  CountrySingleDetail(
                    title: 'Driving side',
                    value: country.drivingSide!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountrySingleDetail extends StatelessWidget {
  const CountrySingleDetail({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: ', style: TextStyle(fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
            value,
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
