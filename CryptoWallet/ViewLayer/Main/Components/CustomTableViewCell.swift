import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CustomTableViewCell"
    
    ///MARK: - UI Elements
        let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundMain
        view.layer.masksToBounds = true
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .textPrimary
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .bold)
        label.textColor = .textPrimary
        return label
    }()
    
    ///MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .green
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
    }
    
    private func setupConstrains() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints() { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)            // Размер 32x32
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(16)
            make.top.equalToSuperview().offset(12)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    ///MARK: - Config
    func configure(with title: String, subtitle: String, iconName: String? = nil) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        if let iconName = iconName {
            iconImageView.image = UIImage(named: iconName) ?? UIImage(systemName: "questionmark.circle")
        }
    }
}
