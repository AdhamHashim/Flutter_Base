plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.appp"
    compileSdk = 36   // ✅ Android 35

    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true

    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.appp"

        // ✅ الصياغة الصحيحة في Kotlin DSL
        minSdk = flutter.minSdkVersion
        targetSdk = 36

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")

        // لازم الاتنين ميتفتحوش الا عند التسليم والرفع الاستور لانهم وظيفتهم لتقليل حجم التطبيق ودمج الكلاسات ويحذف الللغات واللاي اوت اللي مش مستخدم
        isMinifyEnabled = false
        isShrinkResources = false   // ✅ أضف السطر ده
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
    debug {
        signingConfig = signingConfigs.getByName("debug")
    }
}

}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5") // ✅
}

flutter {
    source = "../.."
}
