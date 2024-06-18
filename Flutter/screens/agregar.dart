import 'package:examen_api/models/pago.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Agregar extends StatefulWidget {
  const Agregar({super.key});

  @override
  State<Agregar> createState() => _AgregarState();
}

Future<Pago> agregarPago(Pago pago) async {
  final url = Uri.parse('http://localhost:5174/api/Pago');
  final body = jsonEncode(pago.toJson());
  final headers = {'Content-Type': 'application/json'};
  final response = await http.post(url, body: body, headers: headers);

  if (response.statusCode == 201) {
    final pagoJson = jsonDecode(response.body) as Map<String, dynamic>;
    return Pago.fromJson(pagoJson);
  } else {
    throw Exception('Error al agregar pago: ${response.statusCode}');
  }
}

class _AgregarState extends State<Agregar> {
  final _formKey = GlobalKey<FormState>();
  final _controladorPlaca = TextEditingController();
  final _controladorNombrePeaje = TextEditingController();
  final _controladorIdCategoriaTarifa = TextEditingController();
  final _controladorFechaRegistro = TextEditingController();
  final _controladorValor = TextEditingController();

  void _agregarPago() async {
    if (_formKey.currentState!.validate()) {
      final pago = Pago(
        id: 0, // ID autogenerado por el servidor
        placa: _controladorPlaca.text,
        nombrePeaje: _controladorNombrePeaje.text,
        idCategoriaTarifa: _controladorIdCategoriaTarifa.text,
        fechaRegistro: _controladorFechaRegistro.text,
        valor: int.parse(_controladorValor.text),
      );

      try {
        await agregarPago(pago);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Pago agregado correctamente'),
        ));
        _limpiarCampos();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al agregar pago: $error'),
        ));
      }
    }
  }

  void _limpiarCampos() {
    _controladorPlaca.clear();
    _controladorNombrePeaje.clear();
    _controladorIdCategoriaTarifa.clear();
    _controladorFechaRegistro.clear();
    _controladorValor.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controladorPlaca,
                decoration: const InputDecoration(labelText: 'Placa'),
                validator: (value) {
                  final regex = RegExp(r'[A-Za-z]{3}[0-9]{3}');
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la placa';
                  } else if (!regex.hasMatch(value)) {
                    return 'Formato de placa inválido: 3 letras y 3 números';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controladorNombrePeaje,
                decoration: const InputDecoration(labelText: 'Nombre Peaje'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre del peaje';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controladorIdCategoriaTarifa,
                decoration: const InputDecoration(labelText: 'Id Categoria Tarifa'),
                validator: (value) {
                  final regex = RegExp(r'^[IV]{1,3}$');
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el ID de la categoría de tarifa';
                  } else if (!regex.hasMatch(value)) {
                    return 'ID de categoría inválido. Solo se permiten: I, II, III, IV o V';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controladorFechaRegistro,
                decoration: const InputDecoration(labelText: 'Fecha registro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la fecha de ingreso';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controladorValor,
                keyboardType:
                    TextInputType.number, // Set keyboard type to number
                decoration: const InputDecoration(labelText: 'Valor'),
                validator: (value) {
                  final regex = RegExp(r'^[0-9]+$');
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el valor';
                  } else if (!regex.hasMatch(value)) {
                    return 'Valor inválido: solo se permiten números mayores o iguales a cero';
                  } else if (int.parse(value) < 0) {
                    return 'Valor inválido: debe ser mayor o igual a cero';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _agregarPago,
                child: const Text('Agregar Pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
