plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

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

    defaultConfig {
        applicationId = "com.lazervault.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = maxOf(flutter.minSdkVersion, 23)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            // R8 — Android's modern code-shrinker/obfuscator. Strips unused
            // classes/methods/fields, inlines, renames. Typical app size
            // saving: 30–50% over a non-minified release.
            isMinifyEnabled = true
            // Resource shrinking — strips drawables, strings, layouts, etc.
            // that minified code no longer references. Run AFTER minify so
            // R8's reachability info drives the prune.
            isShrinkResources = true
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
        create("dev") { dimension = "env" }
        create("staging") { dimension = "env" }
        create("prod") { dimension = "env" }
    }

    // Resource configuration — restrict locales to the languages we ship.
    // Every extra locale leaves dead .arsc strings in the APK.
    androidResources {
        // Match the locales lazervaultapp/lib actually loads via flutter_localizations.
        // Add others as we expand. Empty list = keep all (default).
        localeFilters += listOf("en", "en-GB", "fr", "es", "yo", "ig", "ha", "pcm")
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

    // ABI filtering for the dev_firebase APK lane (single artifact has to
    // run on all devices). Limit to arm64-v8a (98%+ of modern Android
    // devices) + armeabi-v7a (legacy 32-bit). x86 emulators picked up via
    // debug builds only.
    defaultConfig {
        ndk {
            //noinspection ChromeOsAbiSupport
            abiFilters += listOf("arm64-v8a", "armeabi-v7a")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
