import UIKit
import SnapKit

final class MainViewController: UIViewController {
    var presenter: IMainViewInput?

    private lazy var mainView = MainView(delegate: self)
    private let refreshControl = UIRefreshControl()
    private let loadingView = LoadingView()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupUI() {
        setupLoadingView()
        setupRefreshControl()
    }

    private func setupLoadingView() {
        loadingView.isHidden = true
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.bringSubviewToFront(loadingView)
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        mainView.tableView.refreshControl = refreshControl
    }

    @objc
    private func refreshData() {
        presenter?.load()
    }
}

extension MainViewController: MainViewDelegate {
    func didSelectTab(index: Int) {
            switch index {
            case 0:
                print("Главная выбрана")
            case 1:
                print("Аналитика выбрана")
            case 2:
                print("Кошелек выбран")
            case 3:
                print("Новости выбраны")
            case 4:
                print("Профиль выбран")
            default:
                break
            }
        }

    
    func didSelectSort() {
        print("Sort button tapped (stub)")
    }
    
    func didSelectRefresh() {
        presenter?.load()
        
    }
    
    func didSelectExit() {
        (presenter as? MainPresenter)?.handleExit()
    }

    func didSelectCurrency(_ currency: CurrencyItem) {
        print("Selected currency: \(currency.name) (\(currency.symbol)) - Price: \(currency.price)")
    }
}

extension MainViewController: IMainViewOutput {
    func update(with state: MainState) {
        switch state {
        case let .result(items):
            loadingView.isHidden = true
            refreshControl.endRefreshing()

            mainView.update(with: items)
        case .loading:
            if presenter?.isFirstAppear() == true {
                loadingView.isHidden = false
            } else {
                refreshControl.beginRefreshing()
                refreshControl.endRefreshing()
            }
        case let .error(error):
            loadingView.isHidden = true
            refreshControl.endRefreshing()

            let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

