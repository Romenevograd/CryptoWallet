import SnapKit
import UIKit

class MainView: UIView {
    
    private let tableView = UITableView()
    private let items = ["btc", "eth", "tron", "luna", "cell", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
}

/// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear
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
