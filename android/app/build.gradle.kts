// Remove deprecated property (AGP 8.1+); may be set by global gradle.properties or cache
try {
    val badKey = "android.bundle.enableUncompressedNativeLibs"
    (project.properties as? MutableMap<String, Any?>)?.remove(badKey)
} catch (_: Exception) { /* properties may be read-only */ }

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ مهم جداً
}

android {
    namespace = "com.aait.flutter_base"
    compileSdk = 36
    ndkVersion = "29.0.13599879"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        jvmToolchain(17)
    }

    defaultConfig {
        applicationId = "com.aait.flutter_base"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Support for 16KB page sizes (Android 15+)
        ndk {
            abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
        }
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug") // مؤقتاً للتجربة
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }

}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

flutter {
    source = "../.."
}

