import UIKit

final class AppCoordinator: ICoordinator {
    private(set) var navigationController: UINavigationController

    private let window: UIWindow
    private let dependencies: IDependencies
    
    private var authCoordinator: AuthCoordinator?
    private var mainCoordinator: MainCoordinator?

    init(
        window: UIWindow,
        navigationController: UINavigationController,
        dependencies: IDependencies
    ) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.window.rootViewController = navigationController
    }

    func start() {
        if isUserLoggedIn() {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }

    private func isUserLoggedIn() -> Bool {
        dependencies.storages.appDefaults.get(for: .loggedIn)
    }

    private func showAuthFlow() {
        authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            dependencies: dependencies,
            delegate: self
        )
        authCoordinator?.start()
    }

    private func showMainFlow() {
        mainCoordinator = MainCoordinator(
            navigationController: navigationController,
            dependencies: dependencies,
            delegate: self
        )
        mainCoordinator?.start()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func didFinishAuth() {
        start()
    }
}

extension AppCoordinator: MainCoordinatorDelegate {
    func didFinishMain() {
        start()
    }
}
