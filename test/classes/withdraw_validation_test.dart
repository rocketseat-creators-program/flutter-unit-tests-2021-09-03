import 'package:flutter_test/flutter_test.dart';
import 'package:tests_unitarios_rocket/classes/withdraw_validation.dart';
import 'package:tests_unitarios_rocket/error/failure.dart';
import 'package:tests_unitarios_rocket/models/operation.dart';
import 'package:tests_unitarios_rocket/models/operation_result.dart';

void main() {
  test('Test validation with value zero', () {
    final withdrawValidation = WithdrawValidation();

    expect(
      () => withdrawValidation.validate(balance: 0.0, value: 0.0),
      throwsA(
        isA<Failure>(),
      ),
    );
  });

  test('Test validation with value is negative', () {
    final withdrawValidation = WithdrawValidation();

    expect(
      () => withdrawValidation.validate(balance: 0.0, value: -100.0),
      throwsA(
        isA<Failure>(),
      ),
    );
  });

  test('Test validation when balance is zero', () {
    final withdrawValidation = WithdrawValidation();

    expect(
      () => withdrawValidation.validate(balance: 0.0, value: 10.0),
      throwsA(
        isA<Failure>(),
      ),
    );
  });

  test('Test when result is ok', () {
    final withdrawValidation = WithdrawValidation();

    OperationResult response =
        withdrawValidation.validate(balance: 150.0, value: 100.0);

    expect(response.result, 50.0);

    expect(response.history.type, OperationType.withdraw);

    expect(response.message, 'Saque realizado com sucesso');
  });
}
