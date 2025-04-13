//
//  BioAuth.swift
//  BioAuth
//

import LocalAuthentication

/// A class that provides biometric authentication functionality using `LAContext`.
///
/// `BiometricIDAuth` conforms to the `BiometricAuthentication` protocol and allows
/// the use of biometric authentication methods such as Face ID or Touch ID.
///
/// - Note: This class uses `LAPolicy.deviceOwnerAuthenticationWithBiometrics` by default,
///   but it can be customized during initialization.
///
final public class BiometricAuth: BiometricAuthentication {
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    
    private var error: NSError?
    
    /// Initializer for the `BiometricAuth` class.
    /// - Parameters:
    ///   - policy: The `LAPolicy` to use for biometric authentication. Defaults to `.deviceOwnerAuthenticationWithBiometrics`.
    ///   - localizedReason: A string that provides the reason for requesting authentication. Defaults to "Verify your Identity".
    ///   - localizedFallBackTitle: A string that provides the fallback button title. Defaults to "Enter Device Passcode".
    ///   - localizedCancelTitle: A string that provides the cancel button title. Defaults to "Cancel".
    public init(
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        localizedReason: String = "Verify your Identity",
        localizedFallBackTitle: String = "Enter App Password",
        localizedCancelTitle: String = "Cancel"
    ) {
        self.policy = policy
        self.localizedReason = localizedReason
        context.localizedFallbackTitle = localizedFallBackTitle
        context.localizedCancelTitle = localizedCancelTitle
    }
    
    ///  A Boolean value indicating whether biometric authentication is enabled on the device
    public var isEnabled: Bool {
        return context.canEvaluatePolicy(policy, error: &error)
    }
    
    /// The type of biometric authentication supported by the device.
    public var supportedType: BiometricType {
        _ = context.canEvaluatePolicy(policy, error: &error)
        return biometricType(for: context.biometryType)
    }
    
    ///  Asynchronously evaluates the biometric authentication policy.
    /// - Returns: A boolean indicating if the biometric authentication is successfully.
    public func evaluate() async throws -> Bool {
        return try await context.evaluatePolicy(
            policy,
            localizedReason: localizedReason
        )
    }
}

public extension BiometricAuth {
    /// Evaluates whether biometric authentication can be performed on the device.
    ///
    /// This method checks if the device supports biometric authentication and if the necessary
    /// conditions are met to evaluate the specified policy. It provides the result through a completion handler.
    ///
    /// - Parameter completion: A closure that is called with the following parameters:
    ///   - success: A Boolean value indicating whether biometric authentication was successful.
    ///   - type: The type of biometric authentication available on the device (e.g., Face ID, Touch ID, or none).
    ///   - error: An optional `BiometricError` value describing the reason for failure, if any.
    ///
    /// The method performs the following steps:
    /// 1. Checks if the `context` can evaluate the specified policy.
    /// 2. If evaluation fails, it determines the type of biometric authentication available and maps
    ///    the error to a `BiometricError` if applicable.
    /// 3. If evaluation succeeds, it returns `true` along with the biometric type and no error.
    func canEvaluate(
        completion: (Bool, BiometricType, BiometricError?) -> Void
    ) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            /// Any statement inside this else block means that it couldn't evaluate the policy
            let type = biometricType(for: context.biometryType)
            
            /// Check if any error is thrown while evaluating the policy
            guard let error = error
            else { return completion(false, type, nil) }
            
            /// If any error, map it to `BiometricError`
            return completion(false, type, biometricError(from: error))
        }
        
        /// Context has successfully evaluated the Policy
        completion(true, biometricType(for: context.biometryType), nil)
    }
}

private extension BiometricAuth {
    /// Converts the given `LABiometryType` to a corresponding `BiometricType`.
    ///
    /// - Parameter type: The `LABiometryType` value to be converted.
    /// - Returns: A `BiometricType` value that corresponds to the provided `LABiometryType`.
    ///
    func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return BiometricType.none
        case .touchID:
            return BiometricType.touchID
        case .faceID:
            return BiometricType.faceID
        case .opticID:
            return BiometricType.opticID
        default:
            return BiometricType.unknown
        }
    }
    
    /// Converts an `NSError` object related to biometric authentication into a `BiometricError` enum value.
    ///
    /// - Parameter nsError: The `NSError` object representing the biometric authentication error.
    /// - Returns: A `BiometricError` enum value corresponding to the provided `NSError`.
    ///
    func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotAvailable
        case LAError.biometryNotEnrolled:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        case LAError.notInteractive:
            error = .notInteractive
        case LAError.systemCancel:
            error = .systemCancel
        case LAError.passcodeNotSet:
            error = .passcodeNotSet
        case LAError.appCancel:
            error = .appCancel
        case LAError.invalidContext:
            error = .invalidContext
        default:
            error = .unknown
        }
        
        return error
    }
}
