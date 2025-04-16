import UIKit

protocol PopupMenuDelegate: AnyObject {
    func didSelectFirstAction()
    func didSelectSecondAction()
}

final class PopupMenuView: UIView {
    // MARK: - Properties
    weak var delegate: PopupMenuDelegate?
    
    // MARK: - UI Elements
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = createActionButton(title: "Refresh", icon: "arrow.clockwise")
        button.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = createActionButton(title: "Exit", icon: "rectangle.portrait.and.arrow.right")
        button.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        addSubview(stackView)
        stackView.addArrangedSubview(refreshButton)
        stackView.addArrangedSubview(exitButton)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    private func createActionButton(title: String, icon: String) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: icon)
        config.title = title
        config.imagePadding = 8
        
        let button = UIButton(configuration: config)
        button.tintColor = .label
        return button
    }
    
    // MARK: - Actions
    @objc private func refreshTapped() {
        delegate?.didSelectFirstAction()
    }
    
    @objc private func exitTapped() {
        delegate?.didSelectSecondAction()
    }
}
