import Foundation

final class MainPresenter: IMainViewInput {
    weak var view: IMainViewOutput?

    private let currencyManager = CurrencyManager()
    private var isFirst = true

    private weak var delegate: (any MainScreenDelegate)?

    init(delegate: (any MainScreenDelegate)?) {
        self.delegate = delegate
    }

    func isFirstAppear() -> Bool {
        isFirst
    }

    func refresh() {
        fetch()
    }

    func load() {
        view?.update(with: .loading)
        isFirst = false
        fetch()
    }
    
    func handleExit() {
        delegate?.handleLogout()
    }

    private func fetch() {
        currencyManager.fetchAllCurrencies { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(items):
                view?.update(with: .result(items: items))
            case let .failure(error):
                view?.update(with: .error(error.localizedDescription))
            }
        }
    }
}
