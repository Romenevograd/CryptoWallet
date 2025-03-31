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
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.text = "Affiliate program"
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
    
    private let serverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "server")
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 16
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Learn more", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
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
        layer.maskedCorners = []
        
        addSubview(serverImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(moreButtonContainer)
        addSubview(learnMoreButton)
        moreButtonContainer.addSubview(moreButton)

        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        serverImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(60)

        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().inset(20)
            make.trailing.lessThanOrEqualTo(moreButton.snp.leading).offset(-16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
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
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(subtitleLabel)
            make.width.equalTo(130)
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
            })
        }
        
    @objc private func learnMoreButtonTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.learnMoreButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
        UIView.animate(withDuration: 0.2) {
            self.learnMoreButton.transform = .identity
        }
        })
        print("Learn more tapped")
    }
        // MARK: - Configuration
        func configure(title: String, subtitle: String) {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
    }
