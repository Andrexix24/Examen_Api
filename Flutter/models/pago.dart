class Pago {
  int id;
  String placa;
  String nombrePeaje;
  String idCategoriaTarifa;
  String fechaRegistro;
  int valor;

  Pago({
    required this.id,
    required this.placa,
    required this.nombrePeaje,
    required this.idCategoriaTarifa,
    required this.fechaRegistro,
    required this.valor,
  });

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
    id: json['id'],
    placa: json['placa'],
    nombrePeaje: json['nombrePeaje'],
    idCategoriaTarifa: json['idCategoriaTarifa'],
    fechaRegistro: json['fechaRegistro'],
    valor: json['valor'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'placa': placa,
    'nombrePeaje': nombrePeaje,
    'idCategoriaTarifa': idCategoriaTarifa,
    'fechaRegistro': fechaRegistro,
    'valor': valor,
  };
}