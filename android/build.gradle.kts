plugins {
    id("com.android.application") version "9.0.1" apply false
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
}

subprojects {
    if (name == "jni") {
        pluginManager.apply("org.jetbrains.kotlin.android")
    }
}