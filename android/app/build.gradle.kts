import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties().apply {
    val file = rootProject.file("keystore.properties")
    if (file.exists()) load(FileInputStream(file))
}
val hasReleaseKeystore = keystoreProperties.getProperty("storeFile")?.isNotBlank() == true

android {
    namespace = "com.lazervault.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // flutter_local_notifications (and any plugin targeting modern Java APIs
        // on minSdk 23) requires core library desugaring to backport java.time
        // and other APIs that aren't available below API 26.
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        freeCompilerArgs = listOf("-Xsuppress-deprecated-jvm-target-warning")
    }

    // AGP 8+ disables BuildConfig generation by default. Re-enable it because
    // the per-flavor blocks below use `buildConfigField(...)` to bake the
    // tier name into the compiled APK.
    buildFeatures {
        buildConfig = true
    }

    defaultConfig {
        applicationId = "com.lazervault.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = maxOf(flutter.minSdkVersion, 23)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKeystore) {
            create("release") {
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // Release builds use the upload keystore (Play Console accepts it,
            // Play App Signing re-signs with the production key on Google's side).
            // Falls back to debug only if keystore.properties is missing — that
            // path is for `flutter run --release` on a dev machine without the
            // keystore set up; Play Console will reject debug-signed AABs.
            signingConfig = if (hasReleaseKeystore) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            // R8 — Android's modern code-shrinker/obfuscator. Strips unused
            // classes/methods/fields, inlines, renames. Typical app size
            // saving: 30–50% over a non-minified release.
            isMinifyEnabled = true
            // Resource shrinking — strips drawables, strings, layouts, etc.
            // that minified code no longer references. Run AFTER minify so
            // R8's reachability info drives the prune.
            isShrinkResources = true
            // Native debug symbols: do NOT bundle them into the AAB. AGP was
            // packaging FULL native symbols for every .so (Flutter engine, libapp,
            // ML Kit, WebRTC) into BUNDLE-METADATA/…debugsymbols — ~191 MB of pure
            // UPLOAD bloat that never ships to a device. "none" strips it entirely.
            // (For production native-crash symbolication, switch to "symbol_table"
            // — still ~10× smaller than "full".)
            ndk {
                debugSymbolLevel = "none"
            }
            // Crunch PNGs at packaging time. WebP conversion is configured
            // separately in androidResources below.
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
        debug {
            // Don't shrink debug — faster build, easier debugging.
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    flavorDimensions += "env"
    productFlavors {
        // Each tier gets a distinct applicationId suffix so a developer can
        // install dev + staging + prod side-by-side on the same device. The
        // dart-defines `FLUTTER_FLAVOR` is read by Dart's
        // `String.fromEnvironment('FLUTTER_FLAVOR')` (see app_environment.dart)
        // and locks the build's tier identity at compile time — no .env
        // file can later override it.
        create("dev") {
            dimension = "env"
            // TODO(firebase): re-enable suffix once an Android app with
            // package `com.lazervault.app.dev` is added in the Firebase
            // Console and `src/dev/google-services.json` is regenerated.
            // Without that, processDevDebugGoogleServices fails the build.
            // applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            buildConfigField("String", "FLUTTER_FLAVOR", "\"dev\"")
            manifestPlaceholders["flavor"] = "dev"
            // NOTE: the Dart-visible FLUTTER_FLAVOR comes ONLY from the CLI
            // `--dart-define=FLUTTER_FLAVOR=<tier>` (→ Flutter's -Pdart-defines).
            // A gradle `extra["dart-defines"]` here is NOT consumed by the
            // Flutter plugin — it was dead config and is intentionally omitted.
        }
        create("staging") {
            dimension = "env"
            // TODO(firebase): same as dev — needs `com.lazervault.app.staging`
            // registered in Firebase Console + a per-flavor google-services.json.
            // applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            buildConfigField("String", "FLUTTER_FLAVOR", "\"staging\"")
            manifestPlaceholders["flavor"] = "staging"
        }
        create("prod") {
            dimension = "env"
            // No applicationIdSuffix — prod is the canonical package id
            // that ships to the Play Store.
            buildConfigField("String", "FLUTTER_FLAVOR", "\"prod\"")
            manifestPlaceholders["flavor"] = "prod"
        }
    }

    // Resource configuration — restrict locales to the languages we ship.
    // Every extra locale leaves dead .arsc strings in the APK.
    androidResources {
        // Format: 2-letter language code, OR 2-letter language + 'r' + 2-letter
        // region (Android's BCP 47 quirk — uppercase region with 'r' prefix).
        // Match the locales lazervaultapp/lib actually loads via flutter_localizations.
        localeFilters += listOf("en", "en-rGB", "fr", "es", "yo", "ig", "ha", "pcm")
    }

    // Bundle splits — Play Console delivers per-device APKs. AAB does this
    // automatically; this block makes the same splitting available for the
    // dev_firebase APK lane too. Density + language + abi splits cut
    // per-device install size by ~40-60%.
    bundle {
        density {
            enableSplit = true
        }
        abi {
            enableSplit = true
        }
        language {
            enableSplit = true
        }
    }

    // Native lib packaging.
    packaging {
        jniLibs {
            // Page-size compatibility: native libs are uncompressed in the APK
            // so the loader can map them directly. Required for 16KB page-size
            // devices (Pixel 9 onwards).
            useLegacyPackaging = false
        }
        resources {
            // Drop META-INF noise that bloats the APK without contributing.
            excludes += listOf(
                "META-INF/AL2.0",
                "META-INF/LGPL2.1",
                "META-INF/*.kotlin_module",
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE*",
                "META-INF/NOTICE*",
            )
        }
    }

    // ABI handling: AABs use the bundle.abi.enableSplit configuration
    // above — Play Store delivers per-ABI APKs to each device. For
    // standalone APKs (dev_firebase lane), the Flutter --split-per-abi
    // flag produces one APK per architecture. We DON'T set
    // defaultConfig.ndk.abiFilters here because it conflicts with
    // bundle.abi.enableSplit (Gradle: "Conflicting configuration: ...
    // in ndk abiFilters cannot be present when splits abi filters are set").
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
