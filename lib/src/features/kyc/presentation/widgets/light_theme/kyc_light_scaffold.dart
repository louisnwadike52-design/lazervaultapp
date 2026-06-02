import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Light-themed scaffold shared by the post-signup KYC screens.
///
/// Matches the BVN + signup pattern: white background, the up-down-curve
/// backdrop, transparent AppBar with a black back arrow, and a scrollable
/// body laid out inside SafeArea. Sets the status-bar icons to dark.
class KycLightScaffold extends StatefulWidget {
  final Widget child;
  final String? title;
  final VoidCallback? onBack;
  final bool showAppBar;

  const KycLightScaffold({
    super.key,
    required this.child,
    this.title,
    this.onBack,
    this.showAppBar = true,
  });

  @override
  State<KycLightScaffold> createState() => _KycLightScaffoldState();
}

class _KycLightScaffoldState extends State<KycLightScaffold> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    // Restore the dark-app default (white icons on dark background) so the
    // next screen the user lands on doesn't inherit our dark-icon override.
    // Without this, popping back to the dashboard leaves the status-bar
    // icons invisible.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: widget.onBack ?? () => Get.back(),
              ),
              title: widget.title != null
                  ? Text(
                      widget.title!,
                      style: const TextStyle(color: Colors.black),
                    )
                  : null,
            )
          : null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg/up-down-curve-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
