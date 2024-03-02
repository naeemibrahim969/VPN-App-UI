class IPDetails {
  late final String country;
  late final String countryShort;
  late final String regionName;
  late final String city;
  late final String zip;
  late final String timezone;
  late final String isp;
  late final String query;

  IPDetails({
    required this.country,
    required this.countryShort,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });

  IPDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'] ?? '';
    countryShort = json['countryCode'] ?? '';
    regionName = json['regionName'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? ' - - - - ';
    timezone = json['timezone'] ?? 'Unknown';
    isp = json['isp'] ?? 'Unknown';
    query = json['query'] ?? 'Not available';
  }
}
