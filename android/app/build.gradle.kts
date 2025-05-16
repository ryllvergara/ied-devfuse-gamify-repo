plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // Set the namespace for your app 
    namespace = "com.example.gamify"
    
    // Set the compileSdkVersion using Flutter’s settings
    compileSdk = flutter.compileSdkVersion
    
    // Specify the NDK version directly if necessary
    ndkVersion = "27.0.12077973" 

    compileOptions {
        // Java 11 compatibility
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        // Kotlin JVM target version
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Application ID (Unique identifier for the app)
        applicationId = "com.example.gamify" 

        // Minimum and target SDK versions using Flutter's settings
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // Version code and version name
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signing configuration for release (use debug config for testing)
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    // Path to the Flutter SDK (relative path from this file)
    source = "../.." 
}
