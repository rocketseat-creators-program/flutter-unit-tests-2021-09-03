import 'package:tests_unitarios_rocket/models/history.dart';

// Classe que resulta a operação, a mensagem e a história
class OperationResult {
  final String message;
  final double result;
  final History history;

  OperationResult({
    required this.message,
    required this.result,
    required this.history,
  });
}
