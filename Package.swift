// swift-tools-version:5.9
//
// Package.swift
// BioAuth
//
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BioAuth",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "BioAuth",
            targets: ["BioAuth"]
        )
    ],
    targets: [
        .target(
            name: "BioAuth",
            path: "Sources/BioAuth" // Source files directory
        ),
        .testTarget(
            name: "BioAuthTests",
            dependencies: ["BioAuth"],
            path: "Tests/BioAuthTests"
        )
    ]
)
