//
//  BiometricType.swift
//  BioAuth
//

/// An enumeration representing the types of biometric authentication available on a device.
///
/// - `touchID`: Represents Touch ID biometric authentication.
/// - `faceID`: Represents Face ID biometric authentication.
/// - `opticID`: Represents Optic ID biometric authentication.
/// - `none`: Indicates that no biometric authentication is available.
/// - `unknown`: Represents an unknown or unspecified biometric authentication type.
public enum BiometricType: String {
    case touchID = "Touch ID"
    case faceID = "Face ID"
    case opticID = "Optic ID"
    case none = "None"
    case unknown = ""
}
