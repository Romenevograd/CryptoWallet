import UIKit

final class MainViewController: UIViewController {
    private lazy var mainView = MainView(delegate: self)

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool { true }

    override func loadView() {
        view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension MainViewController: MainViewDelegate {
    func didSelectRefresh() {
        // Handle refresh action
    }
    
    func didSelectExit() {
        // Handle exit action
    }
    
    func didSelectCurrency(_ currency: CurrencyItem) {
        // Handle currency selection
        print("Selected currency: \(currency.name)")
    }
}
