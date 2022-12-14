import 'package:flutter/foundation.dart';

/// Is ultimately resolved to Row or Column MainAxisAlignment or CrossAxisAlignment
enum EaziAlignment { start, center, end }

/// To be called in the main function of flutter app to handle overflow errors from [RowWidget]
class EaziGridFlowHandler {
  /// To be used in case other error handlers are to be used
  static FlutterExceptionHandler? _otherErrorHandler;

  /// Only public method to be called from fluter app main function.
  /// If other error [FlutterExceptionHandler]'s would have to be defined, assign them to [otherErrorHandler] and they
  /// would be triggered when Flutter Exceptions occur
  static void handleEaziError([FlutterExceptionHandler? otherErrorHandler]) {
    EaziGridFlowHandler._otherErrorHandler = otherErrorHandler;
    FlutterError.onError = _onErrorIgnoreEaziOverflowErrors;
  }

  /// Main error handler method to be used to detect and cancel RenderFlex errors from [RowWidget]
  static void _onErrorIgnoreEaziOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    bool ifIsOverflowError = false;

    final exception = details.exception;
    if (exception is FlutterError) {
      final errorVal = details.toString();
      ifIsOverflowError = errorVal.contains("eazi_row_widget.dart");
    }
    if (ifIsOverflowError) {
      // Is gone
    } else if (_otherErrorHandler != null) {
      _otherErrorHandler!.call(details);
    } else {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  }
}
