import SnapKit
import UIKit

protocol MainViewDelegate: AnyObject {
    func didSelectRefresh()
    func didSelectExit()
    func didSelectCurrency(_ currency: CurrencyItem)
    func didSelectSort()
    func didSelectTab(index: Int)
}

final class MainView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    private let sortMenuView = SortMenuView()
    private var isSortMenuVisible = false
    private let customTabBar = CustomTabBar()

    private let headerView = MainHeaderView()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundMain
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private let bottomViewLabel: UILabel = {
       let bottomViewLabel = UILabel()
        bottomViewLabel.text = "Trending"
        bottomViewLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        bottomViewLabel.textColor = .textPrimary
       return bottomViewLabel
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private var items: [CurrencyItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: MainViewDelegate?
    
    init(delegate: MainViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with items: [CurrencyItem]) {
        self.items = items
    }

    
    private func setupUI() {
        addSubview(headerView)
        addSubview(tableView)
        addSubview(bottomView)
        addSubview(customTabBar)
        
        backgroundColor = .accentPink
        setupHeaderView()
        setupTableView()
        setupBottomView()
        setupTabBar()
        
    }
    
    private func setupTabBar() {
        addSubview(customTabBar)
        customTabBar.delegate = self
        customTabBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
        
        bringSubviewToFront(customTabBar)
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        headerView.delegate = self
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(340)
        }
    }
    
    private func setupBottomView() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 60))
        container.addSubview(bottomView)
        
        sortButton.setImage(UIImage(named: "search"), for: .normal)
        sortButton.tintColor = .textPrimary
        sortButton.backgroundColor = .backgroundMain
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        sortButton.animatePulse()
        
        bottomView.addSubview(sortButton)
        sortButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        bottomView.addSubview(bottomViewLabel)
        bottomViewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        bottomView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sortMenuView.delegate = self
        sortMenuView.isHidden = true
        addSubview(sortMenuView)
        
        tableView.tableHeaderView = container
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(customTabBar.snp.top)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    @objc private func sortButtonTapped() {
        isSortMenuVisible.toggle()
        sortMenuView.isHidden = !isSortMenuVisible
        
        if isSortMenuVisible {
            bringSubviewToFront(sortMenuView)
            sortMenuView.snp.remakeConstraints { make in
                make.top.equalTo(bottomView.snp.bottom).offset(8)
                make.trailing.equalTo(sortButton.snp.trailing)
                make.width.equalTo(150)
            }
            layoutIfNeeded()
        }
        
        sortButton.animatePulse()
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! CustomTableViewCell
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCurrency(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainView: MainHeaderViewDelegate {
    func didSelectRefresh() {
        delegate?.didSelectRefresh()
    }
    
    func didSelectExit() {
        delegate?.didSelectExit()
    }
}

extension MainView: SortMenuDelegate {
    func didSelectSortOption() {
        isSortMenuVisible = false
        sortMenuView.isHidden = true
        delegate?.didSelectSort()
    }
}

extension MainView: CustomTabBarDelegate {
    func didSelectTab(index: Int) {
        delegate?.didSelectTab(index: index)
    }
}
