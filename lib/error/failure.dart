
// Classe para tratamento de erros

class Failure implements Exception {
  final String message;

  Failure({this.message = ''});
}
