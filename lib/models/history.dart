import 'package:tests_unitarios_rocket/models/operation.dart';

// Classe que registra as operações do usuário

class History {
  final OperationType type;
  final DateTime dateTime;
  final double value;

  History({
    required this.type,
    required this.dateTime,
    required this.value,
  });

  // Define o título da operação pelo tipo dela
  String get description =>
      type == OperationType.deposit ? 'Depósito' : 'Saque';
}
