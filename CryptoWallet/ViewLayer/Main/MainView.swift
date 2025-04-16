import SnapKit
import UIKit

protocol MainViewDelegate: AnyObject {
    func didSelectRefresh()
    func didSelectExit()
    func didSelectCurrency(_ currency: CurrencyItem)
}

final class MainView: UIView {
    // MARK: - Properties
    private let headerView = MainHeaderView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let items: [CurrencyItem] = [
        CurrencyItem(name: "Bitcoin", symbol: "BTC"),
        CurrencyItem(name: "Ethereum", symbol: "ETH"),
        CurrencyItem(name: "Tron", symbol: "TRX"),
        CurrencyItem(name: "Terra", symbol: "LUNA"),
        CurrencyItem(name: "Cellframe", symbol: "CELL"),
        CurrencyItem(name: "Dogecoin", symbol: "DOGE"),
        CurrencyItem(name: "Tether", symbol: "USDT"),
        CurrencyItem(name: "Stellar", symbol: "XLM"),
        CurrencyItem(name: "Cardano", symbol: "ADA"),
        CurrencyItem(name: "Ripple", symbol: "XRP")
    ]
    
    weak var delegate: MainViewDelegate?
    
    // MARK: - Init
    init(delegate: MainViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .backgroundMain
        setupHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        headerView.delegate = self
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(340)
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource & Delegate
extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: item.name, subtitle: item.symbol, iconName: item.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCurrency(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MainHeaderViewDelegate
extension MainView: MainHeaderViewDelegate {
    func didSelectRefresh() {
        delegate?.didSelectRefresh()
    }
    
    func didSelectExit() {
        delegate?.didSelectExit()
    }
}
