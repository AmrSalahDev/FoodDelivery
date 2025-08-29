import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@LazySingleton()
class LocationService {
  final Location _location = Location();

  /// Ensures that location service and permissions are enabled.
  Future<bool> ensureServiceEnabled() async {
    // Check if location service is enabled
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    // Check for location permissions
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  /// Returns the user's current address as a string.
  Future<String?> getCurrentAddress() async {
    final locationData = await _location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      return null;
    }

    final placemarks = await geocoding.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );

    if (placemarks.isEmpty) return null;

    final place = placemarks.first;
    return place.street ?? place.locality ?? place.country ?? "";
  }

  /// Returns raw location coordinates (latitude, longitude).
  Future<LocationData> getCurrentCoordinates() async {
    return await _location.getLocation();
  }
}
