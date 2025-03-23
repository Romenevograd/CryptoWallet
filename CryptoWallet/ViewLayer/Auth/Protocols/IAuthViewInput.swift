import Foundation

protocol IAuthViewInput {
    func didNameChanged(_ name: String)
    func didPasswordChanged(_ password: String)
    func logIn()
}
