import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../cubit/open_banking_cubit.dart';
import '../../cubit/open_banking_state.dart';

/// Screen to link a bank account using Mono Connect
class LinkBankScreen extends StatefulWidget {
  final String userId;
  final String accessToken;

  const LinkBankScreen({
    super.key,
    required this.userId,
    required this.accessToken,
  });

  @override
  State<LinkBankScreen> createState() => _LinkBankScreenState();
}

class _LinkBankScreenState extends State<LinkBankScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  String? _publicKey;
  String? _appId;
  bool _configLoaded = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
    _loadConfig();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle Mono Connect redirect
            if (request.url.contains('mono-connect://')) {
              _handleMonoRedirect(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'MonoConnect',
        onMessageReceived: (JavaScriptMessage message) {
          _handleMonoMessage(message.message);
        },
      );
  }

  void _loadConfig() {
    context.read<OpenBankingCubit>().getConnectConfig(widget.accessToken);
  }

  void _loadMonoWidget() {
    if (_publicKey == null || _appId == null) return;

    final html = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      background-color: #f5f5f5;
    }
    #loading {
      text-align: center;
      color: #666;
    }
    .spinner {
      border: 4px solid #f3f3f3;
      border-top: 4px solid #6C5CE7;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
      margin: 0 auto 20px;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
  <div id="loading">
    <div class="spinner"></div>
    <p>Connecting to your bank...</p>
  </div>

  <script src="https://connect.mono.co/connect.js"></script>
  <script>
    const connect = new Connect({
      key: "$_publicKey",
      onSuccess: function(data) {
        // Send code back to Flutter
        MonoConnect.postMessage(JSON.stringify({
          type: 'success',
          code: data.code
        }));
      },
      onClose: function() {
        MonoConnect.postMessage(JSON.stringify({
          type: 'close'
        }));
      },
      onEvent: function(eventName, data) {
        MonoConnect.postMessage(JSON.stringify({
          type: 'event',
          event: eventName,
          data: data
        }));
      }
    });

    // Auto-open the widget
    connect.open();
  </script>
</body>
</html>
''';

    _webViewController.loadHtmlString(html);
  }

  void _handleMonoRedirect(String url) {
    final uri = Uri.parse(url);
    final code = uri.queryParameters['code'];

    if (code != null) {
      _linkAccount(code);
    }
  }

  void _handleMonoMessage(String message) {
    try {
      final Map<String, dynamic> data =
          Map<String, dynamic>.from(Uri.decodeComponent(message) as Map);

      switch (data['type']) {
        case 'success':
          final code = data['code'] as String?;
          if (code != null) {
            _linkAccount(code);
          }
          break;
        case 'close':
          Navigator.pop(context, false);
          break;
        case 'event':
          // Handle events (logging, analytics)
          debugPrint('Mono event: ${data['event']} - ${data['data']}');
          break;
      }
    } catch (e) {
      // Try parsing as simple JSON
      if (message.startsWith('{')) {
        try {
          final data = _parseJson(message);
          if (data != null) {
            switch (data['type']) {
              case 'success':
                final code = data['code'] as String?;
                if (code != null) {
                  _linkAccount(code);
                }
                break;
              case 'close':
                Navigator.pop(context, false);
                break;
            }
          }
        } catch (_) {}
      }
      debugPrint('Error handling Mono message: $e');
    }
  }

  Map<String, dynamic>? _parseJson(String json) {
    try {
      // Simple JSON parsing without dart:convert import here
      // This is just for message parsing
      if (json.contains('"type":"success"') && json.contains('"code":')) {
        final codeMatch = RegExp(r'"code":"([^"]+)"').firstMatch(json);
        if (codeMatch != null) {
          return {
            'type': 'success',
            'code': codeMatch.group(1),
          };
        }
      } else if (json.contains('"type":"close"')) {
        return {'type': 'close'};
      }
    } catch (_) {}
    return null;
  }

  void _linkAccount(String code) {
    context.read<OpenBankingCubit>().linkAccount(
          userId: widget.userId,
          code: code,
          accessToken: widget.accessToken,
          setAsDefault: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Link Your Bank'),
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: BlocConsumer<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is ConnectConfigLoaded) {
            setState(() {
              _publicKey = state.publicKey;
              _appId = state.appId;
              _configLoaded = true;
            });
            _loadMonoWidget();
          } else if (state is AccountLinked) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.isNewAccount
                      ? 'Bank account linked successfully!'
                      : 'Bank account reconnected!',
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is OpenBankingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is OpenBankingLoading || state is AccountLinkingInProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF6C5CE7),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state is AccountLinkingInProgress
                        ? 'Linking your bank account...'
                        : 'Loading...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          if (!_configLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF6C5CE7),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Preparing secure connection...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              WebViewWidget(controller: _webViewController),
              if (_isLoading)
                Container(
                  color: Colors.white.withValues(alpha: 0.8),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6C5CE7),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
