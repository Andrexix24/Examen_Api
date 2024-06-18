import 'package:examen_api/screens/agregar.dart';
import 'package:examen_api/screens/foto.dart';
import 'package:examen_api/screens/geolocalizacion.dart';
import 'package:examen_api/screens/listar.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Pagos', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: DecoratedBox( 
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Container( 
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: ListTile(
                  leading: const Icon(Icons.list, color: Colors.white,),
                  title: const Text('Listar pagos', style: TextStyle(color: Colors.white),),
                  trailing: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => const Listar(),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: ListTile(
                  leading: const Icon(Icons.create, color: Colors.white,),
                  title: const Text('Registrar pagos', style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => const Agregar(),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: ListTile(
                  leading: const Icon(Icons.image, color: Colors.white,),
                  title: const Text('Tomar Foto', style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => const Foto(),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Colors.white,),
                  title: const Text('Geolocalizacion', style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => const Geolocalizacion(),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
