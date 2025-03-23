import Foundation

final class AuthPresenter: IAuthViewInput {
    weak var view: IAuthViewOutput?

    private weak var delegate: (any AuthScreenDelegate)?

    private var model = AuthModel()

    init(delegate: (any AuthScreenDelegate)?) {
        self.delegate = delegate
    }

    func didNameChanged(_ name: String) {
        model.name = name
        view?.update(with: .result(model))
    }

    func didPasswordChanged(_ password: String) {
        model.password = password
        view?.update(with: .result(model))
    }

    func logIn() {
        delegate?.didLoggedIn()
    }
}
