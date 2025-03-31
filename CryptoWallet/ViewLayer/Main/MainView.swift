import SnapKit
import UIKit

class MainView: UIView {
    
    private let headerView = HeaderView()
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
        backgroundColor = .Background.pink
        
        setupHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.reloadData()
        tableView.clipsToBounds = true
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.cornerRadius = 24
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
        
        if indexPath.row == 0 {
            cell.containerView.layer.cornerRadius = 12
            cell.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.containerView.layer.masksToBounds = true
        } else {
            cell.containerView.layer.cornerRadius = 0
        }
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
