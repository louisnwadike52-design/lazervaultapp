import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'package:lazervault/src/core/services/analytics_service.dart';

/// Error Boundary Widget
/// Catches errors in the widget tree and displays a user-friendly error screen
/// Logs errors to analytics for monitoring
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final void Function(Object error, StackTrace? stackTrace)? onError;
  final AnalyticsService? analyticsService;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
    this.analyticsService,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    _initializeErrorReporting();
  }

  /// The handler that was installed before this boundary mounted.
  ///
  /// main.dart installs one that prints the exception and ships it, with its
  /// stack, to Loki — on a real device that is the ONLY readable crash
  /// channel; logcat carries just an analytics counter. This widget used to
  /// REPLACE it outright, so mounting an ErrorBoundary anywhere would have
  /// silently destroyed crash reporting app-wide, leaving red screens with no
  /// message, no stack and no widget name. (That exact blindness cost an hour
  /// on 2026-10-08 before the Loki feed was found.) Chain to it instead, and
  /// hand it back on dispose.
  FlutterExceptionHandler? _priorOnError;

  void _initializeErrorReporting() {
    _priorOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      // presentError is the framework default — only fall back to it if there
      // was genuinely no prior handler, otherwise the error is presented twice.
      (_priorOnError ?? FlutterError.presentError)(details);
      _handleError(details.exception, details.stack);
    };
  }

  @override
  void dispose() {
    // Only give the handler back if it is still ours; something mounted later
    // may legitimately own it now, and clobbering that would repeat the bug.
    FlutterError.onError = _priorOnError;
    super.dispose();
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    // A build/layout/paint error arrives DURING a frame, and setState() in
    // that phase throws — turning one broken widget into a second crash
    // inside the crash handler. Defer to after the frame when mid-flight.
    void show() {
      if (!mounted) return;
      setState(() {
        _error = error;
        _stackTrace = stackTrace;
      });
    }

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      show();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => show());
    }

    // Log to analytics
    widget.analyticsService?.trackError(
      error: error.toString(),
      stackTrace: stackTrace.toString(),
      properties: {
        'screen': 'ErrorBoundary',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    // Call custom error handler
    widget.onError?.call(error, stackTrace);
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!, _stackTrace) ??
          _DefaultErrorWidget(
            error: _error!,
            stackTrace: _stackTrace,
            onRetry: () {
              setState(() {
                _error = null;
                _stackTrace = null;
              });
            },
          );
    }

    return ErrorCapturingWidget(
      onError: _handleError,
      child: widget.child,
    );
  }
}

/// Internal widget that captures errors in child widgets
class ErrorCapturingWidget extends SingleChildRenderObjectWidget {
  final void Function(Object error, StackTrace? stackTrace) onError;

  const ErrorCapturingWidget({
    super.key,
    super.child,
    required this.onError,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ErrorCapturingRenderObject(onError);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant ErrorCapturingRenderObject renderObject,
  ) {
    renderObject.onError = onError;
  }
}

class ErrorCapturingRenderObject extends RenderProxyBox {
  void Function(Object error, StackTrace? stackTrace) onError;

  ErrorCapturingRenderObject(this.onError);

  @override
  void performLayout() {
    try {
      super.performLayout();
    } catch (e, stack) {
      onError(e, stack);
    }
  }
}

/// Default error widget
class _DefaultErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback onRetry;

  const _DefaultErrorWidget({
    required this.error,
    required this.stackTrace,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 40,
                    color: Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(height: 24),

                // Error Title
                const Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 12),

                // Error Message
                Text(
                  error.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Retry Button
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Go Home Button
                OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to home
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Go to Dashboard'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4E03D0),
                    side: const BorderSide(
                      color: Color(0xFF4E03D0),
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Show details in debug mode
                if (kDebugMode) ...[
                  const SizedBox(height: 32),
                  ExpansionTile(
                    title: const Text(
                      'Error Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Text(
                          stackTrace.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Error Boundary Observer
/// Monitors app lifecycle and performance
class ErrorBoundaryObserver extends WidgetsBindingObserver {
  final AnalyticsService analyticsService;
  final List<PerformanceMetric> metrics = [];

  ErrorBoundaryObserver({
    required this.analyticsService,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    analyticsService.trackEvent(
      eventName: 'app_lifecycle_changed',
      properties: {
        'state': state.name,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Start measuring performance
  void startPerformanceMeasure(String name) {
    metrics.add(PerformanceMetric(
      name: name,
      startTime: DateTime.now(),
    ));
  }

  /// End measuring performance
  void endPerformanceMeasure(String name) {
    final metric = metrics.cast<PerformanceMetric?>().firstWhere(
          (m) => m?.name == name,
          orElse: () => null,
        );

    if (metric != null) {
      final duration = DateTime.now().difference(metric.startTime);
      analyticsService.trackEvent(
        eventName: 'performance_metric',
        properties: {
          'name': name,
          'duration_ms': duration.inMilliseconds,
        },
      );
      metrics.remove(metric);
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}

/// Performance Metric Model
class PerformanceMetric {
  final String name;
  final DateTime startTime;

  PerformanceMetric({
    required this.name,
    required this.startTime,
  });
}

/// Crash Reporting Service
class CrashReportingService {
  final AnalyticsService analyticsService;
  final List<CrashReport> _crashReports = [];

  CrashReportingService({
    required this.analyticsService,
  });

  /// Report a crash
  Future<void> reportCrash({
    required Object error,
    required StackTrace stackTrace,
    Map<String, dynamic>? context,
  }) async {
    final report = CrashReport(
      error: error.toString(),
      stackTrace: stackTrace.toString(),
      timestamp: DateTime.now(),
      context: context ?? {},
    );

    _crashReports.add(report);

    // Send to analytics
    await analyticsService.trackError(
      error: error.toString(),
      stackTrace: stackTrace.toString(),
      properties: context,
    );

    // In production, send to crash reporting service
    // await _sendToCrashReportingService(report);
  }

  /// Get all crash reports
  List<CrashReport> getCrashReports() {
    return List.unmodifiable(_crashReports);
  }

  /// Clear all crash reports
  void clearCrashReports() {
    _crashReports.clear();
  }
}

/// Crash Report Model
class CrashReport {
  final String error;
  final String stackTrace;
  final DateTime timestamp;
  final Map<String, dynamic> context;

  CrashReport({
    required this.error,
    required this.stackTrace,
    required this.timestamp,
    required this.context,
  });

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'stackTrace': stackTrace,
      'timestamp': timestamp.toIso8601String(),
      'context': context,
    };
  }
}

/// Memory and Performance Monitoring
class PerformanceMonitor {
  final AnalyticsService analyticsService;

  PerformanceMonitor({
    required this.analyticsService,
  });

  /// Monitor memory usage
  Future<MemoryUsage> getMemoryUsage() async {
    // In production, use platform channels to get actual memory usage
    return MemoryUsage(
      totalMemory: 0,
      usedMemory: 0,
      percentage: 0.0,
    );
  }

  /// Track memory usage
  Future<void> trackMemoryUsage() async {
    final usage = await getMemoryUsage();
    await analyticsService.trackEvent(
      eventName: 'memory_usage',
      properties: {
        'total_mb': usage.totalMemory,
        'used_mb': usage.usedMemory,
        'percentage': usage.percentage,
      },
    );
  }
}

/// Memory Usage Model
class MemoryUsage {
  final int totalMemory; // in MB
  final int usedMemory; // in MB
  final double percentage;

  MemoryUsage({
    required this.totalMemory,
    required this.usedMemory,
    required this.percentage,
  });
}
