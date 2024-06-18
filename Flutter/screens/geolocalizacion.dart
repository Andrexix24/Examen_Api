import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geolocalizacion extends StatefulWidget {
  const Geolocalizacion({super.key});

  @override
  State<Geolocalizacion> createState() => _GeolocalizacionState();
}

Future<Position> getCurrentLocation() async {
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

class _GeolocalizacionState extends State<Geolocalizacion> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await getCurrentLocation();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('localizacion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPosition != null)
              Text(
                'Latitud: ${_currentPosition!.latitude.toStringAsFixed(4)}\nLongitud: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                style: TextStyle(fontSize: 20),
              )
            else
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}