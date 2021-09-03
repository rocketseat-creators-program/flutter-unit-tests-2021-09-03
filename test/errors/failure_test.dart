import 'package:flutter_test/flutter_test.dart';
import 'package:tests_unitarios_rocket/error/failure.dart';

void main() {
  test('Test throw exception failure with message', () {
    final function = () {
      throw Failure(message: 'Falha executada');
    };

    expect(
      function,
      throwsA(
        isA<Failure>(),
      ),
    );
  });

  test('Test throw exception failure without message', () {
    final function = () {
      throw Failure();
    };

    expect(
      function,
      throwsA(
        isA<Failure>(),
      ),
    );
  });

  test('Test failure message', () {
    final failure = Failure(message: 'Falha executada');

    expect(failure.message, 'Falha executada');
  });

  test('Test failure without message', () {
    final failure = Failure();

    expect(failure.message, '');
  });
}
