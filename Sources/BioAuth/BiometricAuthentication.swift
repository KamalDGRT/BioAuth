//
//  BiometricAuthentication.swift
//  BioAuth
//

/// A protocol that defines the requirements for biometric authentication functionality.
///
/// Types conforming to this protocol provide information about the supported biometric type,
/// whether biometric authentication is enabled, and a method to evaluate authentication.
///
/// - Note: This protocol is designed to work with asynchronous operations.
///
/// ## Properties
/// - `isEnabled`: A Boolean value indicating whether biometric authentication is enabled on the device.
/// - `supportedType`: The type of biometric authentication supported by the device.
///
/// ## Methods
/// - `evaluate()`: Asynchronously evaluates the biometric authentication and returns a Boolean
///   indicating whether the authentication was successful.
///
/// ## Usage
/// Conform to this protocol to implement biometric authentication in your application.
public protocol BiometricAuthentication {
    var isEnabled: Bool { get }
    var supportedType: BiometricType { get }
    func evaluate() async throws -> Bool
}
