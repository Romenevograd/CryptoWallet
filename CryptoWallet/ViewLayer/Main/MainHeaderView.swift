import UIKit
import SnapKit

class HeaderView: UIView {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "Home"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        label.text = "subtitle"
        return label
    }()
    
    private let moreButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        return view
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .Background.pink
        
        addSubview(textStackView)
        addSubview(moreButtonContainer)
        moreButtonContainer.addSubview(moreButton)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(moreButton.snp.leading).offset(-16)
        }
        
        moreButtonContainer.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(44)
        }
        
        moreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24) // Размер иконки внутри круга
        }
    }
    
    // MARK: - Actions
        @objc private func moreButtonTapped() {
            UIView.animate(withDuration: 0.2, animations: {
                self.moreButtonContainer.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.moreButtonContainer.alpha = 0.8
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.moreButtonContainer.transform = .identity
                    self.moreButtonContainer.alpha = 1.0
                }
                print("More button tapped")
                // Действие при нажатии
            })
        }
        
        // MARK: - Configuration
        func configure(title: String, subtitle: String) {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
    }
