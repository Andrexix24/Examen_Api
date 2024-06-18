import 'package:examen_api/models/pago.dart';
import 'package:examen_api/screens/editar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Listar extends StatefulWidget {
  const Listar({super.key});

  @override
  State<Listar> createState() => _ListarState();
}

Future<List<Pago>> listarPagos() async {
  final url = Uri.parse('http://localhost:5174/api/Pago');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final pagosJson = jsonDecode(response.body) as List<dynamic>;
    return pagosJson.map((pagoJson) => Pago.fromJson(pagoJson)).toList();
  } else {
    throw Exception('Error al listar pagos: ${response.statusCode}');
  }
}

class _ListarState extends State<Listar> {
  Future<void> eliminarPago(int pagoId) async {
    final url = Uri.parse('http://localhost:5174/api/Pago/$pagoId');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        // Handle successful deletion (e.g., show snackbar, update list)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Pago eliminado correctamente'),
        ));
        // Update UI or list of payments based on your implementation
      } else {
        throw Exception('Error al eliminar pago: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar pago: $error'),
      ));
    }
  }

  Widget sizedIcon(IconData icon, double size) {
  return SizedBox(
    height: size,
    width: size,
    child: Icon(icon),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar pagos'),
      ),
      body: FutureBuilder<List<Pago>>(
        future: listarPagos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("compras no encontradas"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pago = snapshot.data![index];
                return ListTile(
                  title: Text(pago.placa),
                  subtitle: Text(
                      "ID: ${pago.id}\nPlaca: ${pago.placa}\nNombre Peaje: ${pago.nombrePeaje}\nFecha: ${pago.fechaRegistro}\nValor: ${pago.valor}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            final route = MaterialPageRoute(
                              builder: (context) => Editar(
                                pago: pago,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                          icon: sizedIcon(Icons.edit, 18.0),
                      ),
                      IconButton(
                          onPressed: () {
                            eliminarPago(pago.id);
                          },
                          icon: sizedIcon(Icons.delete, 18.0),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
