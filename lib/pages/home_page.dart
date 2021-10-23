import 'package:flutter/material.dart';
import 'package:tests_unitarios_rocket/models/operation.dart';
import 'package:tests_unitarios_rocket/models/user.dart';
import 'package:tests_unitarios_rocket/pages/operation_page.dart';

import 'widgets/header_widget.dart';
import 'widgets/history_list_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user = User(balance: 0, history: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              user: _user,
              onDeposit: () => _toOperationPage(OperationType.deposit),
              onWithdraw: () => _toOperationPage(OperationType.withdraw),
            ),
            HistoryListWidget(
              user: _user,
            ),
          ],
        ),
      ),
    );
  }

  // Vai para a página da operação de acordo com o tipo de operação (Depósito ou Saque)
  Future<void> _toOperationPage(OperationType type) async {
    final response = await showModalBottomSheet<User>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 48,
          child: OperationPage(
            operationType: type,
            user: _user,
            // Mostra o snackbar de sucesso caso a operação seja concluida
            onSuccess: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
            // Mostra um dialog de erro caso a validação retorne uma
            // falha ao realizar a operação
            onError: (error) {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Ops...'),
                    content: Text(
                      error.message,
                      key: Key('ErrorMessage'),
                    ),
                    actions: [
                      TextButton(
                        key: Key('OkButton'),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Ok',
                          key: Key('TextButton'),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );

    // Caso de tudo certo os novos dados são retornados
    if (response != null) {
      setState(() {
        // O usuário recebe o usuário com os novos dados e a tela é atualizada
        _user = response;
      });
    }
  }
}
