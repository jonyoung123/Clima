
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (!serviceEnabled){
        throw Exception('Location services are disabled.');
      }else if (permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission==LocationPermission.denied){
          throw Exception('Location Permission is denied');
        }
      }else if(permission== LocationPermission.deniedForever){
        throw Exception('Permission permanently denied, unable to request Permission');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch(e){
      print(e);
    }
  }
}