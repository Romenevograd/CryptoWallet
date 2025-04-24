import UIKit
import SnapKit

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(index: Int)
}

final class CustomTabBar: UIView {

    weak var delegate: CustomTabBarDelegate?
    private var selectedIndex: Int = 0

    // Фиксированные кнопки (5 штук)
    private let homeButton = UIButton(type: .system)
    private let analyzButton = UIButton(type: .system)
    private let walletButton = UIButton(type: .system)
    private let newsButton = UIButton(type: .system)
    private let profileButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .backgroundMainLighter
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 4

        setupButtons()
    }

    private func setupButtons() {
        configureButton(homeButton, iconName: "Home", tag: 0)
        configureButton(analyzButton, iconName: "Analyz", tag: 1)
        configureButton(walletButton, iconName: "Wallet", tag: 2)
        configureButton(newsButton, iconName: "News", tag: 3)
        configureButton(profileButton, iconName: "Profile", tag: 4)

        // Расположение кнопок в стеке
        let stackView = UIStackView(arrangedSubviews: [
            homeButton, analyzButton, walletButton, newsButton, profileButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(56)
        }

        // Обновляем стиль выбранной кнопки
        updateSelection()
    }

    private func configureButton(_ button: UIButton, iconName: String, tag: Int) {
        button.setImage(UIImage(named: iconName), for: .normal)
        button.tintColor = tag == selectedIndex ? .systemBlue : .gray
        button.tag = tag
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateSelection()
        delegate?.didSelectTab(index: sender.tag)
    }

    private func updateSelection() {
        let buttons = [homeButton, analyzButton, walletButton, newsButton, profileButton]
        buttons.forEach { button in
            button.tintColor = button.tag == selectedIndex ? .gray : .textPrimary
        }
    }
}
