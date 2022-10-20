import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: SimplePrinter(),
  level: kDebugMode ? Level.debug : Level.info,
);
