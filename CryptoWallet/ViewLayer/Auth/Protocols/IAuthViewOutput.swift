import Foundation

protocol IAuthViewOutput: AnyObject {
    func update(with state: AuthState)
}
