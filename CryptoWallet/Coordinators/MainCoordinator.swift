import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didFinishMain()
}

final class MainCoordinator: ICoordinator {
    private(set) var navigationController: UINavigationController

    private weak var delegate: MainCoordinatorDelegate?

    private let dependencies: IDependencies

    init(
        navigationController: UINavigationController,
        dependencies: IDependencies,
        delegate: MainCoordinatorDelegate?
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.delegate = delegate
    }

    func start() {
        let mainVC = MainViewController()
        navigationController.setViewControllers([mainVC], animated: false)
    }

    func showCoinsList() {
        let coinsListVC = UIViewController()
        navigationController.pushViewController(coinsListVC, animated: true)
    }

    func showAuthFlow() {
        delegate?.didFinishMain()
    }
}
