// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    dependencies: [
         .package(url: "https://github.com/mac-cain13/R.swift", from: "6.1.0"),
    ]
)
