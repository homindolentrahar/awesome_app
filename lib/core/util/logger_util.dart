import 'package:awesome_app/core/constant/api_constant.dart';
import 'package:logger/logger.dart';

class LoggerUtil {
  static late Logger _logger;

  final LogPrinter _withoutTracePrinter = PrettyPrinter(
    printEmojis: false,
    stackTraceBeginIndex: 0,
    methodCount: 0,
    errorMethodCount: 0,
  );

  LoggerUtil._({bool withTracer = false}) {
    _logger = Logger(
      printer: withTracer
          ? PrettyPrinter(
              printEmojis: false,
              stackTraceBeginIndex: 1,
              methodCount: 6,
            )
          : _withoutTracePrinter,
    );
  }

  factory LoggerUtil.instance({bool withTracer = true}) =>
      LoggerUtil._(withTracer: withTracer);

  void logApi({
    required ApiType type,
    required String url,
    required String method,
    int code = -1,
    String jwtToken = "",
    Map<String, dynamic> header = const {},
    Map<String, dynamic> body = const {},
    Map<String, dynamic> data = const {},
    Level level = Level.debug,
  }) {
    _logger = Logger(printer: _withoutTracePrinter);

    final List<String> logBuffer = [];
    final contentType = header['Content-Type'];
    final appId = header['app-id'];
    final appSecret = header['app-secret'];
    final token = header['auth'];

    logBuffer.add(type.name.toUpperCase());
    logBuffer.add("${method.toUpperCase()} - $url");

    if (type == ApiType.response) {
      if (code > 0) {
        logBuffer.add("Code: $code");
      }
    }
    if (contentType != null) {
      logBuffer.add("Content Type: $contentType");
    }
    if (appId != null) {
      logBuffer.add("App ID: $appId");
    }
    if (appSecret != null) {
      logBuffer.add("App Secret: $appSecret");
    }
    if (token != null) {
      logBuffer.add("Token: $token");
    }
    if (jwtToken.isNotEmpty) {
      logBuffer.add("JWT: $jwtToken");
    }
    if (body.isNotEmpty) {
      logBuffer.add("Body: $body");
    }
    if (type == ApiType.response) {
      if (data.isNotEmpty) {
        logBuffer.add("Data: $data");
      }
    }

    switch (level) {
      case Level.debug:
        debug(logBuffer.join("\n"));
        break;
      case Level.info:
        info(logBuffer.join("\n"));
        break;
      case Level.warning:
        warning(logBuffer.join("\n"));
        break;
      case Level.trace:
        trace(logBuffer.join("\n"));
        break;
      case Level.error:
        error(logBuffer.join("\n"));
        break;
      default:
        debug(logBuffer.join("\n"));
    }
  }

  void warning(String message) {
    _logger.w(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void trace(String message) {
    _logger.t(message);
  }

  void debug(String message) {
    _logger.d(message);
  }

  void error(String message) {
    _logger.e(message);
  }
}
