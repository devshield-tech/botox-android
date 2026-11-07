# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-keep class com.destructo.botox.Configuration { *; }

# --- Retrofit / OkHttp / Gson ---------------------------------------------
# Retrofit resolves generic types and annotations reflectively. R8 strips the
# Signature attribute by default, which turns Call<JsonObject> into a raw Call
# and makes Retrofit throw:
#   IllegalArgumentException: Unable to create call adapter for interface ...
#   Call return type must be parameterized as Call<Foo> or Call<? extends Foo>
-keepattributes Signature, InnerClasses, EnclosingMethod
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations
-keepattributes AnnotationDefault

# Keep the Retrofit service interface and its generic return types.
-keep interface com.destructo.botox.SubscriptionActivity$ApiService { *; }
-keep class com.destructo.botox.SubscriptionActivity$ApiService { *; }

# Keep serialized/model classes so Gson can read their fields reflectively.
-keep class com.destructo.botox.** { *; }

# Retrofit, OkHttp and Okio internals.
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-dontwarn retrofit2.**
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**

# Gson reflective access.
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**
-keep class org.openjsse.** { *; }
-dontwarn org.openjsse.**
