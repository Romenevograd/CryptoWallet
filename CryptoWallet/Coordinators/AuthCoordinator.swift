import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func didFinishAuth()
}

final class AuthCoordinator: ICoordinator {
    private(set) var navigationController: UINavigationController

    private weak var delegate: AuthCoordinatorDelegate?

    private let dependencies: IDependencies

    init(
        navigationController: UINavigationController,
        dependencies: IDependencies,
        delegate: AuthCoordinatorDelegate?
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.delegate = delegate
    }

    func start() {
        navigationController.setViewControllers([AuthBuilder.build(delegate: self)], animated: true)
    }

    func showMainFlow() {
        delegate?.didFinishAuth()
    }
}

extension AuthCoordinator: AuthScreenDelegate {
    func didLoggedIn() {
        showMainFlow()
    }
}
