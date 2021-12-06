import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

extension LoggerX on Level {
  SentryLevel toSentryLevel() {
    if (this == Level.CONFIG) {
      return SentryLevel.debug;
    }
    if (this == Level.INFO) {
      return SentryLevel.info;
    }
    if (this == Level.WARNING) {
      return SentryLevel.warning;
    }

    return SentryLevel.error;
  }
}

class AppLogger {
  void initLogging() {
    Logger.root.level = Level.INFO;
    Logger.root.onRecord.listen((data) async {
      if (!kReleaseMode) {
        logDeveloper(data);
      } else {
        if (data.level.value >= Level.WARNING.value) {
          uploadLogMessage(data);
        }
      }
    });
  }

  void logDeveloper(LogRecord data) {
    // ignore: avoid_print
    print(<dynamic>[
      data.level,
      DateFormat('yyyy-MM-dd HH:mm:ss').format(data.time),
      data.loggerName,
      data.message,
      if (data.error != null) data.error,
      if (data.stackTrace != null) data.stackTrace
    ]);
  }

  void uploadLogMessage(LogRecord data) {
    final message = '${data.loggerName}: ${data.message}';
    if (data.error == null) {
      Sentry.captureMessage(
        message,
        level: data.level.toSentryLevel(),
      );
    } else {
      Sentry.captureException(
        data.error,
        stackTrace: data.stackTrace,
        hint: message,
      );
    }
  }
}
