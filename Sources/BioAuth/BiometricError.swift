//
//  BiometricError.swift
//  BioAuth
//

import Foundation

/// An enumeration representing various biometric authentication errors.
/// Conforms to the `LocalizedError` protocol to provide user-friendly error descriptions.
public enum BiometricError: LocalizedError {
    
    /// Error indicating that the authentication process failed.
    /// - Description: "There was a problem verifying your identity."
    case authenticationFailed
    
    /// Error indicating that the user canceled the authentication process.
    /// - Description: "You pressed cancel."
    case userCancel
    
    /// Error indicating that the user opted to use a fallback method (e.g., password).
    /// - Description: "You pressed password."
    case userFallback
    
    /// Error indicating that biometric authentication is not available on the device.
    /// - Description: "Face ID/Touch ID is not available."
    case biometryNotAvailable
    
    /// Error indicating that biometric authentication is not set up on the device.
    /// - Description: "Face ID/Touch ID is not set up."
    case biometryNotEnrolled
    
    /// Error indicating that biometric authentication is locked due to multiple failed attempts.
    /// - Description: "Face ID/Touch ID is locked."
    case biometryLockout
    
    /// Error indicating an unknown issue with biometric authentication.
    /// - Description: "Face ID/Touch ID may not be configured."
    case unknown
    
    /// A localized description of the error, providing user-friendly feedback.
    public var errorDescription: String? {
        switch self {
        case .authenticationFailed:
            return "There was a problem verifying your identity."
        case .userCancel:
            return "You pressed cancel."
        case .userFallback:
            return "You pressed password."
        case .biometryNotAvailable:
            return "Face ID/Touch ID is not available."
        case .biometryNotEnrolled:
            return "Face ID/Touch ID is not set up."
        case .biometryLockout:
            return "Face ID/Touch ID is locked."
        case .unknown:
            return "Face ID/Touch ID may not be configured"
        }
    }
}
