//
//  BiometricError.swift
//  BioAuth
//

import Foundation

/// An enumeration representing various biometric authentication errors.
/// Conforms to the `LocalizedError` protocol to provide user-friendly error descriptions.
public enum BiometricError: LocalizedError {
    
    /// Error indicating that the authentication process failed.
    case authenticationFailed
    
    /// Error indicating that the user canceled the authentication process.
    case userCancel
    
    /// Error indicating that the user opted to use a fallback method (e.g., password).
    case userFallback
    
    /// Error indicating that biometric authentication is not available on the device.
    case biometryNotAvailable
    
    /// Error indicating that biometric authentication is not set up on the device.
    case biometryNotEnrolled
    
    /// Error indicating that biometric authentication is locked due to multiple failed attempts.
    case biometryLockout
    
    case notInteractive
    
    case systemCancel
    
    case passcodeNotSet
    
    case appCancel
    
    case invalidContext
    
    /// Error indicating an unknown issue with biometric authentication.
    /// - Description: "Face ID/Touch ID may not be configured."
    case unknown
    
    /// A localized description of the error, providing user-friendly feedback.
    public var errorDescription: String? {
        switch self {
        case .authenticationFailed:
            return "There was a problem verifying your identity."
        case .userCancel:
            return "The user tapped the cancel button in the authentication dialog."
        case .userFallback:
            return "The user tapped the fallback button in the authentication dialog, but no fallback is available for the authentication policy."
        case .biometryNotAvailable:
            return "Authentication could not start, because biometry is not available on the device."
        case .biometryNotEnrolled:
            return "Authentication could not start, because biometry has no enrolled identities."
        case .biometryLockout:
            return "Authentication was not successful, because there were too many failed biometry attempts and biometry is now locked."
        case .notInteractive:
            return "Displaying the required authentication user interface is forbidden."
        case .systemCancel:
            return "The system canceled authentication."
        case .passcodeNotSet:
            return "Please goto the Settings & Turn On Passcode"
        case .appCancel:
            return "The app canceled authentication."
        case .invalidContext:
            return "Invalid Context"
        case .unknown:
            return "Face ID/Touch ID may not be configured"
        }
    }
}
