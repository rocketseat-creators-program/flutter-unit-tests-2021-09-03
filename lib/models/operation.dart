import 'package:tests_unitarios_rocket/classes/validate_factory.dart';

import 'operation_result.dart';

// Classe da operação

enum OperationType { deposit, withdraw }

class Operation {
  final double balance;
  final double value;
  final OperationType type;

  Operation({required this.balance, required this.value, required this.type});

  // Faz a validação e a operação
  OperationResult doOperation() {
    return ValidationFactory(this).validate();
  }
}

