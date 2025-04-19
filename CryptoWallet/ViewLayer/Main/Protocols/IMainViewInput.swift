import Foundation

protocol IMainViewInput {
    func isFirstAppear() -> Bool

    func load()
    func refresh()
}
