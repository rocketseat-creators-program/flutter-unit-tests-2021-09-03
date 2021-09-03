import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tests_unitarios_rocket/pages/home_page.dart';
import 'package:tests_unitarios_rocket/pages/operation_page.dart';

void main() {
  testWidgets('Test inital state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    await tester.pump();

    expect(find.text('Saldo disponível'), findsOneWidget);

    expect(find.byKey(const Key('BalanceKey')), findsOneWidget);

    expect(find.text('Depositar'), findsOneWidget);

    expect(find.text('Sacar'), findsOneWidget);

    expect(find.text('Nenhuma operação recente.'), findsOneWidget);
  });

  testWidgets('Test deposit action', (tester) async {
    // Renderiza o widget
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    await tester.pump();

    // Achou o botão depositar
    final depositButton = find.text('Depositar');

    // Fez a ação do Tap no botão
    await tester.tap(depositButton);

    await tester.pumpAndSettle();

    // Mostrou bottomsheet
    expect(find.byType(OperationPage), findsOneWidget);

    // Achou a caixa de texto
    final operationValue = find.byKey(Key('OperationValueKey'));

    // Digitou 100
    await tester.enterText(operationValue, '100');

    // Esperou a animação
    await tester.pumpAndSettle();

    final operationContinue = find.byKey(Key('OperationContinue'));

    // Clickou no continue
    await tester.tap(operationContinue);

    // Esperou a animação
    await tester.pumpAndSettle();

    // Confirmou o sucesso com o snackbar
    expect(find.text('Depósito realizado com sucesso'), findsOneWidget);
  });
}
