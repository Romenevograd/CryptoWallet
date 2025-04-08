import SnapKit
import UIKit

protocol MainViewDelegate: AnyObject {
    func didSelectActionMenu()
}

struct CurrencyItem {
    let name: String
    let symbol: String
}

final class MainView: UIView {
    let headerView = MainHeaderView()

    private let maxHeight: CGFloat = 360
    private let minHeight: CGFloat = 360

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

    private weak var delegate: MainViewDelegate?

    init(delegate: MainViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .backgroundMain
        setupHeaderView()
        setupTableView()
    }

    private func setupHeaderView() {
        addSubview(headerView)
        headerView.onMore = { [weak self] in
            self?.delegate?.didSelectActionMenu()
        }
        headerView.backgroundColor = .accentPink
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(minHeight)
        }
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = .clear
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = maxHeight
        tableView.setContentOffset(.init(x: 0, y: -maxHeight), animated: false)
        tableView.reloadData()

        bringSubviewToFront(headerView)
    }

    private func calculateHeaderViewHeight(for currentOffset: CGFloat) {
        if currentOffset <= 0 {
            setHeaderViewHeight(for: maxHeight + abs(currentOffset))
        } else {
            var newHeight = maxHeight - currentOffset
            if newHeight < minHeight {
                newHeight = minHeight
            }
            setHeaderViewHeight(for: newHeight)
        }
    }

    private func setHeaderViewHeight(for newHeight: CGFloat) {
        headerView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }

        layoutIfNeeded()
    }
}

// MARK: - UITableViewDataSource

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell else {
            return UITableViewCell()
        }

        let item = items[indexPath.row]
        cell.configure(
            with: item.name,
            subtitle: item.symbol,
            iconName: item.symbol.lowercased()
        )

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //убирает анимацию выделения
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y + scrollView.contentInset.top
        calculateHeaderViewHeight(for: currentOffset)
    }
}
