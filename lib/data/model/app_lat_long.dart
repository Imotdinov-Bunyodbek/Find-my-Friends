class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });


}
class DefaultLocation extends AppLatLong {
  const DefaultLocation({
    super.lat = 41.321168,
    super.long = 69.254675,
  });}