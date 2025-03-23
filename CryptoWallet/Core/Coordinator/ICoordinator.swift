import UIKit

public protocol ICoordinator {
    var navigationController: UINavigationController { get }

    func start()
}
