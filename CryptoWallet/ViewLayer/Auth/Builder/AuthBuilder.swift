import UIKit

protocol AuthScreenDelegate: AnyObject {
    func didLoggedIn()
}

enum AuthBuilder {
    static func build(delegate: (any AuthScreenDelegate)?) -> UIViewController {
        let view = AuthViewController()
        let presenter = AuthPresenter(delegate: delegate)

        presenter.view = view
        view.presenter = presenter

        return view
    }
}
