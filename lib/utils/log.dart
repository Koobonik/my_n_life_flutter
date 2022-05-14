import 'package:logger/logger.dart';

class Log{
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );
  static void info(log){
    logger.i(log);
  }
  static void error(log){
    logger.e(log);
  }
  static void debug(log){
    logger.d(log);
  }
  static void warning(log){
    logger.w(log);
  }
  static void verbose(log){
    logger.v(log);
  }
  static void wtf(log){
    logger.wtf(log);
  }
}