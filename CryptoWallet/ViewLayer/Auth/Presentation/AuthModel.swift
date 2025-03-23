import Foundation

struct AuthModel: Equatable {
    var name = ""
    var password = ""

    var isValid: Bool {
        !name.isEmpty && !password.isEmpty
    }
}
