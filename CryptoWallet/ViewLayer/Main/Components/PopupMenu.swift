import UIKit

protocol PopupMenuDelegate: AnyObject {
    func didSelectRefreshAction()
    func didSelectExitAction()
}

final class PopupMenuView: UIView {
    // MARK: - Properties
    weak var delegate: PopupMenuDelegate?
    
    // MARK: - UI Elements
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = createActionButton(
            title: "Обновить",
            icon: "rocket",
            textColor: .textPrimary,
            iconColor: .textPrimary
        )
        button.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = createActionButton(
            title: "Выйти",
            icon: "trash",
            textColor: .textPrimary,
            iconColor: .textPrimary
        )
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
        backgroundColor = .backgroundMain
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
    
    private func createActionButton(title: String, icon: String, textColor: UIColor, iconColor: UIColor) -> UIButton {
            var config = UIButton.Configuration.plain()
            
            config.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
            config.imageColorTransformer = UIConfigurationColorTransformer { _ in iconColor }
            config.imagePadding = 5
            
            let attributes = AttributeContainer([
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: textColor
            ])
            config.attributedTitle = AttributedString(title, attributes: attributes)
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
            config.titleAlignment = .leading
            config.imagePlacement = .leading
            
            let button = UIButton(configuration: config)
            button.contentHorizontalAlignment = .left
            button.tintColor = iconColor
            
            return button
        }
    
    // MARK: - Actions
    @objc private func refreshTapped() {
        delegate?.didSelectRefreshAction()
    }
    
    @objc private func exitTapped() {
        delegate?.didSelectExitAction()
    }
}
