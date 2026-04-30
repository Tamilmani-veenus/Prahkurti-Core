import 'package:logger/logger.dart';


var loggerNoStack = Logger(
  printer: PrettyPrinter(lineLength: 150,printEmojis: false,methodCount: 0),
);

void printToLog(String message) {
  loggerNoStack.t(" LOG :: $message");
}
