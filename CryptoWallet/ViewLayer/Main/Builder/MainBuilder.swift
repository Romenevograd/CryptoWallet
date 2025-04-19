import UIKit

protocol MainScreenDelegate: AnyObject {}

enum MainBuilder {
    static func build(delegate: (any MainScreenDelegate)?) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(delegate: delegate)

        presenter.view = view
        view.presenter = presenter

        return view
    }
}
