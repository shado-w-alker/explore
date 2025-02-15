class CountryModel {
  String? name;
  dynamic capital;
  Map<String, dynamic>? flag;
  String? officail;
  dynamic coatOfArm;
  Map<String, dynamic>? map;
  int? population;
  String? region;
  String? motto;
  Map<String, dynamic>? languages;
  double? area;
  dynamic currency;
  String? ethnic;
  String? religion;
  String? government;
  String? independence;
  String? gdp;

  List? timeZone;
  String? dateFormat;
  Map<String, dynamic>? diallingCode;
  String? drivingSide;
  List? continent;

  CountryModel({
    this.name,
    this.capital,
    this.flag,
    this.officail,
    this.coatOfArm,
    this.map,
    this.population,
    this.region,
    this.motto,
    this.languages,
    this.area,
    this.currency,
    this.ethnic,
    this.religion,
    this.government,
    this.independence,
    this.gdp,
    this.timeZone,
    this.dateFormat,
    this.diallingCode,
    this.drivingSide,
    this.continent,
  });

  factory CountryModel.fromMap(Map<String, dynamic> data) {
    try {
      return CountryModel(
        name: data['name']['common'] as String,
        capital: data['capital'],
        flag: data['flags'] as Map<String, dynamic>,
        officail: data['name']['official'] as String,
        coatOfArm: data['coatOfArms'],
        map: data['maps'] as Map<String, dynamic>,
        population: data['population'] as int,
        region: data['region'] as String,
        languages:
            data['languages'] ?? {'eng': 'english'} as Map<String, dynamic>,
        area: data['area'] as double,
        currency: data['currencies'],
        timeZone: data['timezones'],
        diallingCode: data['idd'],
        continent: data['continents'],
        drivingSide: data['car']['side'] as String,
      );
    } catch (e) {
      return CountryModel();
    }
  }
}
