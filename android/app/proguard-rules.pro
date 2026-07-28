# Flutter ProGuard Rules

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.internal.** { *; }
-keep class io.flutter.provider.** { *; }
-keep class io.flutter.embedding.** { *; }

-keep class **.R$* { *; }

-keepclasseswithmembernames class * {
    native <methods>;
}

# Ignore missing Google Play Core / Feature Delivery classes referenced by Flutter embedding
-dontwarn com.google.android.play.core.**