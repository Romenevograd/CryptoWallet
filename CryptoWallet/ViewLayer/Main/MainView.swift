import SnapKit
import UIKit

class MainView: UIView {
    
    private let tableView = UITableView()
    private let items = [
        ("Bitcoin", "BTC"),
        ("Ethereum", "ETH"),
        ("Tron", "TRX"),
        ("Terra", "LUNA"),
        ("Cellframe", "CELL"),
        ("Dogecoin", "DOGE"),
        ("Tether", "USDT"),
        ("Stellar", "XLM"),
        ("Cardano", "ADA"),
        ("Ripple", "XRP")
    ]
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .Background.pink
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.reloadData()
        tableView.clipsToBounds = true
    }
}

/// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
            let item = items[indexPath.row]
                    cell.configure(
                        with: item.0, //Вопрос!!!
                        subtitle: item.1,
                        iconName: item.1.lowercased()
                    )
                    return cell
    }
}

/// MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Выбрана ячейка \(items[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true) //убирает анимацию выделения
    }
}
