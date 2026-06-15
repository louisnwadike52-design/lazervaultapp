# LazerVault Android — R8 / ProGuard rules.
# These keeps prevent R8 from stripping classes that are accessed via
# reflection or JNI (where R8 can't see the references statically).
# Without these, the minified app crashes at runtime on plugin calls.

# ============================================================================
# Flutter framework
# ============================================================================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }
-keepclassmembers class * { @io.flutter.plugin.common.MethodChannel$MethodCallHandler *; }
-dontwarn io.flutter.embedding.**

# ============================================================================
# Firebase + Play Services
# ============================================================================
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# ============================================================================
# Flutter plugins that use reflection or JNI
# ============================================================================
# WebRTC
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**
# LiveKit
-keep class io.livekit.** { *; }
-dontwarn io.livekit.**
# Camera + scanner
-keep class androidx.camera.** { *; }
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**
# Secure storage
-keep class androidx.security.crypto.** { *; }
# Speech + TTS
-keep class com.google.cloud.** { *; }
-dontwarn com.google.cloud.**
# NFC
-keep class android.nfc.** { *; }
# Sign in with Apple
-keep class com.aboutyou.dart_packages.** { *; }

# ============================================================================
# Mobile_scanner (CameraX + ML Kit)
# ============================================================================
-keep class com.google.zxing.** { *; }
-dontwarn com.google.zxing.**

# ============================================================================
# Local notifications
# ============================================================================
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class * extends androidx.core.app.NotificationCompat$Style { *; }

# ============================================================================
# gRPC / protobuf — reflection-based serialization
# ============================================================================
-keep class com.google.protobuf.** { *; }
-keep class io.grpc.** { *; }
-dontwarn com.google.protobuf.**
-dontwarn io.grpc.**

# ============================================================================
# Stripe / payment SDKs that may be loaded dynamically
# ============================================================================
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# ============================================================================
# Generic — keep model classes annotated with @Keep or used by Gson/Moshi
# ============================================================================
-keep @androidx.annotation.Keep class * { *; }
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# ============================================================================
# Kotlin coroutines — keep for plugin compatibility
# ============================================================================
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepclassmembers class kotlinx.coroutines.** {
    volatile <fields>;
}

# ============================================================================
# Suppress warnings for missing classes that aren't actually used at runtime
# ============================================================================
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.**
-dontwarn com.android.installreferrer.**

# Preserve line numbers for crash reports (small size impact, big debug win)
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
