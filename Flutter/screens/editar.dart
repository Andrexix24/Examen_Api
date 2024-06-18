import 'package:examen_api/models/pago.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Editar extends StatefulWidget {
  final Pago pago;

  const Editar({super.key, required this.pago});
  @override
  State<Editar> createState() => _EditarState();
}

Future<Pago> editarPago(Pago pago) async {
  final url = Uri.parse('http://localhost:5174/api/Pago/${pago.id}');
  final body = jsonEncode(pago.toJson());
  final headers = {'Content-Type': 'application/json'};
  final response = await http.put(url, body: body, headers: headers);

  if (response.statusCode == 200) {
    final pagoJson = jsonDecode(response.body) as Map<String, dynamic>;
    return Pago.fromJson(pagoJson);
  } else {
    throw Exception('Error al editar pago: ${response.statusCode}');
  }
}

class _EditarState extends State<Editar> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _controladorPlaca = TextEditingController(); // Controller for placa field
  final _controladorNombrePeaje = TextEditingController(); // Controller for nombrePeaje field
  final _controladorIdCategoriaTarifa = TextEditingController(); // Controller for idCategoriaTarifa field
  final _controladorFechaRegistro = TextEditingController(); // Controller for fechaRegistro field
  final _controladorValor = TextEditingController(); 

   @override
  void initState() {
    super.initState();
    _controladorPlaca.text = widget.pago.placa;
    _controladorNombrePeaje.text = widget.pago.nombrePeaje;
    _controladorIdCategoriaTarifa.text = widget.pago.idCategoriaTarifa;
    _controladorFechaRegistro.text = widget.pago.fechaRegistro;
    _controladorValor.text = widget.pago.valor.toString();
  }

  // @override
  // void dispose() {
  //   _controladorPlaca.dispose();
  //   _controladorNombrePeaje.dispose();
  //   _controladorIdCategoriaTarifa.dispose();
  //   _controladorFechaRegistro.dispose();
  //   _controladorValor.dispose();
  //   super.dispose();
  // }

  Future<void> _editarPago() async {
    // Validate form fields and display error messages if necessary
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pago = Pago(
      id: widget.pago.id,
      placa: _controladorPlaca.text,
      nombrePeaje: _controladorNombrePeaje.text,
      idCategoriaTarifa: _controladorIdCategoriaTarifa.text,
      fechaRegistro: _controladorFechaRegistro.text,
      valor: int.parse(_controladorValor.text),
    );

    try {
      await editarPago(pago);
      // Handle successful edit (e.g., show snackbar, navigate back)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Pago editado correctamente'),
      ));
      Navigator.pop(context); // Assuming navigation back after edit
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al editar pago: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Pago"),
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
                onPressed: _editarPago,
                child: const Text('Editar Pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}