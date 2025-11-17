// android/build.gradle.kts
// Root-level Gradle configuration for EaseMilker (Flutter + Firebase + Kotlin)

plugins {
    // Only declare Google Services plugin here
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: keep your build outputs organized outside android/
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

// Apply consistent build output path for all subprojects
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// Clean task for all modules
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
