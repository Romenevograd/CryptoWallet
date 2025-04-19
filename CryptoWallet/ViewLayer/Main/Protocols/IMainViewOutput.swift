import Foundation

protocol IMainViewOutput: AnyObject {
    func update(with state: MainState)
}
