import 'package:flutter_driver/flutter_driver.dart' as dr;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  final DateFormat _dateFormatter = DateFormat('d/M/y');
  group('Should test the deposit operation', () {
    late dr.FlutterDriver driver;

    setUpAll(() async {
      driver = await dr.FlutterDriver.connect();
    });

    tearDownAll(() {
      driver.close();
    });

    test('Should deposit value with success', () async {
      final depostiButton = dr.find.byValueKey('DepositButton');

      final balance = dr.find.byValueKey('BalanceKey');

      final historyEmpty = dr.find.byValueKey('HistoryEmpty');

      expect(await driver.getText(balance), 'R\$ 0,00');

      expect(await driver.getText(historyEmpty), 'Nenhuma operação recente.');

      await driver.tap(depostiButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final operationTextField = dr.find.byValueKey('OperationValueKey');

      await driver.tap(operationTextField);

      await driver.enterText('5000');

      final continueButton = dr.find.byValueKey('OperationContinue');

      await driver.tap(continueButton);

      await driver.waitFor(dr.find.byType('HomePage'));

      expect(await driver.getText(balance), 'R\$ 50,00');

      final historyTitle = dr.find.byValueKey('HistoryTitle0');

      expect(await driver.getText(historyTitle), 'Depósito');

      final historySubtitle = dr.find.byValueKey('HistorySubtitle0');

      expect(await driver.getText(historySubtitle), 'R\$ 50,00');

      final date = _dateFormatter.format(DateTime.now());

      final historyDate = dr.find.byValueKey('HistoryDate0');

      expect(await driver.getText(historyDate), date);
    });

    test('Should deposit value with error', () async {
      final depostiButton = dr.find.byValueKey('DepositButton');

      final balance = dr.find.byValueKey('BalanceKey');

      expect(await driver.getText(balance), 'R\$ 50,00');

      await driver.tap(depostiButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final operationTextField = dr.find.byValueKey('OperationValueKey');

      await driver.tap(operationTextField);

      await driver.enterText('0');

      final continueButton = dr.find.byValueKey('OperationContinue');

      await driver.tap(continueButton);

      await driver.waitFor(dr.find.byType('AlertDialog'));

      final errorMessage = dr.find.byValueKey('ErrorMessage');

      expect(await driver.getText(errorMessage),
          'Não é posssível depositar esse valor.');

      final okButton = dr.find.byValueKey('OkButton');

      await driver.tap(okButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final close = dr.find.byValueKey('CloseOperation');

      await driver.tap(close);

      await driver.waitFor(dr.find.byType('HomePage'));

      expect(await driver.getText(balance), 'R\$ 50,00');
    });
  });

  group('Should test the withdraw operation', () {
    late dr.FlutterDriver driver;

    setUpAll(() async {
      driver = await dr.FlutterDriver.connect();
    });

    tearDownAll(() {
      driver.close();
    });

    test('Should withdraw value with success', () async {
      final depostiButton = dr.find.byValueKey('WithdrawButton');

      final balance = dr.find.byValueKey('BalanceKey');

      expect(await driver.getText(balance), 'R\$ 50,00');

      await driver.tap(depostiButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final operationTextField = dr.find.byValueKey('OperationValueKey');

      await driver.tap(operationTextField);

      await driver.enterText('1000');

      final continueButton = dr.find.byValueKey('OperationContinue');

      await driver.tap(continueButton);

      await driver.waitFor(dr.find.byType('HomePage'));

      expect(await driver.getText(balance), 'R\$ 40,00');

      final historyTitle = dr.find.byValueKey('HistoryTitle0');

      expect(await driver.getText(historyTitle), 'Saque');

      final historySubtitle = dr.find.byValueKey('HistorySubtitle0');

      expect(await driver.getText(historySubtitle), 'R\$ 10,00');

      final date = _dateFormatter.format(DateTime.now());

      final historyDate = dr.find.byValueKey('HistoryDate0');

      expect(await driver.getText(historyDate), date);
    });

    test('Should withdraw value with error 0', () async {
      final depostiButton = dr.find.byValueKey('WithdrawButton');

      final balance = dr.find.byValueKey('BalanceKey');

      expect(await driver.getText(balance), 'R\$ 40,00');

      await driver.tap(depostiButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final operationTextField = dr.find.byValueKey('OperationValueKey');

      await driver.tap(operationTextField);

      await driver.enterText('0');

      final continueButton = dr.find.byValueKey('OperationContinue');

      await driver.tap(continueButton);

      await driver.waitFor(dr.find.byType('AlertDialog'));

      final errorMessage = dr.find.byValueKey('ErrorMessage');

      expect(await driver.getText(errorMessage),
          'Não é posssível sacar esse valor.');

      final okButton = dr.find.byValueKey('OkButton');

      await driver.tap(okButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final close = dr.find.byValueKey('CloseOperation');

      await driver.tap(close);

      await driver.waitFor(dr.find.byType('HomePage'));

      expect(await driver.getText(balance), 'R\$ 40,00');
    });

    test('Should withdraw value with error balance', () async {
      final depostiButton = dr.find.byValueKey('WithdrawButton');

      final balance = dr.find.byValueKey('BalanceKey');

      expect(await driver.getText(balance), 'R\$ 40,00');

      await driver.tap(depostiButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final operationTextField = dr.find.byValueKey('OperationValueKey');

      await driver.tap(operationTextField);

      await driver.enterText('5000');

      final continueButton = dr.find.byValueKey('OperationContinue');

      await driver.tap(continueButton);

      await driver.waitFor(dr.find.byType('AlertDialog'));

      final errorMessage = dr.find.byValueKey('ErrorMessage');

      expect(await driver.getText(errorMessage), 'Saldo insuficiente.');

      final okButton = dr.find.byValueKey('OkButton');

      await driver.tap(okButton);

      await driver.waitFor(dr.find.byType('OperationPage'));

      final close = dr.find.byValueKey('CloseOperation');

      await driver.tap(close);

      await driver.waitFor(dr.find.byType('HomePage'));

      expect(await driver.getText(balance), 'R\$ 40,00');
    });
  });
}
