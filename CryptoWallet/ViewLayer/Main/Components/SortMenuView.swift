import UIKit
import SnapKit

protocol SortMenuDelegate: AnyObject {
    func didSelectSortOption()
}

final class SortMenuView: UIView  {
    weak var delegate: SortMenuDelegate?
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.backgroundColor = .accentPink
        return stack
    }()
    
    private lazy var sortByNameButton: UIButton = {
        let button = createSortButton(
            title: "By Name",
            icon: "",
            textColor: .textPrimary,
            iconColor: .textPrimary
            )
        button.addTarget(self, action: #selector(sortByNameTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortByPriceButton: UIButton = {
        let button = createSortButton(
            title: "By Price",
            icon: "",
            textColor: .textPrimary,
            iconColor: .textPrimary
            )
        button.addTarget(self, action: #selector(sortByPriceTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .accentPink
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        addSubview(stackView)
        stackView.addArrangedSubview(sortByNameButton)
        stackView.addArrangedSubview(sortByPriceButton)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
    }
    
    private func createSortButton(title: String, icon: String, textColor: UIColor, iconColor: UIColor) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        config.imageColorTransformer = UIConfigurationColorTransformer{ _ in iconColor }
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
    
    
    @objc private func sortByNameTapped() {
        delegate?.didSelectSortOption()
    }
    
    @objc private func sortByPriceTapped() {
        delegate?.didSelectSortOption()
    }
}
