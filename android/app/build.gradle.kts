import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
    }
}

val isCiBuild = System.getenv("ANDROID_CI_BUILD") == "true"
val testKeystorePath = System.getenv("ANDROID_TEST_KEYSTORE_PATH")
val hasTestKeystore = !testKeystorePath.isNullOrBlank()

android {
    namespace = "com.magnetys.latin_reader"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.magnetys.latin_reader"
        manifestPlaceholders["appLabel"] = "latin_reader"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasTestKeystore) {
            create("ciTest") {
                storeFile = file(requireNotNull(testKeystorePath))
                storePassword = requireNotNull(System.getenv("ANDROID_TEST_KEYSTORE_PASSWORD")) {
                    "ANDROID_TEST_KEYSTORE_PASSWORD is required when a test keystore is supplied."
                }
                keyAlias = "latin-reader-test"
                keyPassword = storePassword
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            signingConfig = signingConfigs.getByName(if (hasTestKeystore) "ciTest" else "debug")

            // keep downloaded previews separate from local development installs
            if (isCiBuild) {
                applicationIdSuffix = if (hasTestKeystore) ".preview" else ".pr"
                manifestPlaceholders["appLabel"] =
                    if (hasTestKeystore) "Latin Reader Preview" else "Latin Reader PR"
            }
        }
    }
}

flutter {
    source = "../.."
}
