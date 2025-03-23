import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        bootstrap(
            window: window,
            navigationController: navigationController
        )
    }

    private func bootstrap(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        let defaults = DefaultsManager()
        let apiService = APIService(baseURL: AppConstants.baseURL)

        appCoordinator = .init(
            window: window,
            navigationController: navigationController,
            dependencies: DependenciesContainer(
                storages: AppStorages(
                    appDefaults: AppDefaultsManager(defaults: defaults)
                ),
                repositories: AppRepositories(
                    currencies: CryptoCurrenciesRepository(apiService: apiService)
                )
            )
        )
        appCoordinator?.start()
    }
}
