import 'package:tests_unitarios_rocket/models/operation.dart';
import 'package:tests_unitarios_rocket/classes/withdraw_validation.dart';

import 'deposit_validation.dart';
import '../models/operation_result.dart';

// Factory criado para validar de acordo com a operação

class ValidationFactory {
  final Operation operation;

  ValidationFactory(this.operation);

  OperationResult validate() {
    switch (operation.type) {
      case OperationType.deposit:
        return DepositValidation()
            .validate(balance: operation.balance, value: operation.value);
      case OperationType.withdraw:
        return WithdrawValidation()
            .validate(balance: operation.balance, value: operation.value);
    }
  }
}
