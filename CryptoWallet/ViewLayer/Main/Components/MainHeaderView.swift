import UIKit
import SnapKit

protocol MainHeaderViewDelegate: AnyObject {
    func didSelectRefresh()
    func didSelectExit()
}

final class MainHeaderView: UIView {
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .textHeader
        label.text = "Home"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .textHeader
        label.text = "Affiliate program"
        return label
    }()
    
    private let learnMoreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let attributes = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.textPrimary
        ])
        
        config.attributedTitle = AttributedString("Learn more", attributes: attributes)
        config.baseForegroundColor = .textPrimary
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        
        let action = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            button.animatePulse()
        }
            
        let button = UIButton(configuration: config, primaryAction: action)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 18
            button.clipsToBounds = true
            button.backgroundColor = .backgroundMain
        
            return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textPrimary
        button.backgroundColor = .backgroundMain
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let serverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "server")
        return imageView
    }()
    
    private lazy var popupMenu: PopupMenuView = {
        let menu = PopupMenuView()
        menu.delegate = self
        menu.alpha = 0
        menu.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        return menu
    }()
    
    weak var delegate: MainHeaderViewDelegate?
    private var isPopupVisible = false
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .accentPink
        addSubview(serverImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(moreButton)
        addSubview(learnMoreButton)
        addSubview(popupMenu)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(moreButton.snp.leading).offset(-16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(100)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(44)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        serverImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(10)
            make.width.equalTo(220)
            make.height.equalTo(300)
            
        }
        
        popupMenu.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(8)
            make.trailing.equalTo(moreButton)
            make.width.equalTo(150)
        }
    }
    
    // MARK: - Actions
    @objc private func moreButtonTapped() {
        togglePopup()
    }
    
    @objc private func learnMoreButtonTapped() {
        learnMoreButton.animatePulse()
    }
    
    private func togglePopup() {
        isPopupVisible.toggle()
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut]) {
            self.popupMenu.alpha = self.isPopupVisible ? 1 : 0
            self.popupMenu.transform = self.isPopupVisible ? .identity : CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    // MARK: - Configuration
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

extension MainHeaderView: PopupMenuDelegate {
    func didSelectRefreshAction() {
        delegate?.didSelectRefresh()
        togglePopup()
    }
    
    func didSelectExitAction() {
        delegate?.didSelectExit()
        togglePopup()
    }
}
