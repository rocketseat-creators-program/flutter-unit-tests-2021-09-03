import 'package:tests_unitarios_rocket/models/history.dart';
import 'package:tests_unitarios_rocket/models/operation.dart';
import 'package:tests_unitarios_rocket/models/operation_result.dart';

import '../error/failure.dart';

// Valida a operação de depósito

class DepositValidation {
  OperationResult validate({required double balance, required double value}) {
    if (value == 0.0 || value < 0.0) {
      throw Failure(message: 'Não é posssível depositar esse valor.');
    }

    return OperationResult(
      message: 'Depósito realizado com sucesso',
      result: balance + value,
      history: History(
        type: OperationType.deposit,
        dateTime: DateTime.now(),
        value: value,
      ),
    );
  }
}
