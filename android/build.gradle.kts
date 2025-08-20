import org.gradle.api.tasks.Delete
import org.gradle.kotlin.dsl.register

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Keep your existing Android Gradle plugin
        classpath("com.android.tools.build:gradle:8.3.1") // replace with your version if different

        // Add Google Services plugin for Firebase
        classpath("com.google.gms:google-services:4.3.15") // latest stable
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Custom build directory configuration (your original code)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
