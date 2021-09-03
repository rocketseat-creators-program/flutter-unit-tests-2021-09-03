import 'package:tests_unitarios_rocket/models/history.dart';

// Classe do usuário

class User {
  final double balance;
  final List<History> history;

  User({required this.balance, this.history = const <History>[]});

  User update({
    double? balance,
    History? history,
  }) {

    // Pega a lista atual
    final list = this.history;

    if (history != null) {

      // Adiciona a nova operação a lista
      list.add(history);
    }

    // Ordena a lista do mais recente para o mais antigo
    this.history.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    // Cria um novo usuário com os dados atualizados
    return User(
      balance: balance ?? this.balance,
      history: list,
    );
  }
}
