import UIKit

final class InputTextField: UIView {
    var onEditingChanged: ((String) -> Void)?

    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let inputTextField = UITextField()

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    func update(with model: Model) {
        iconImageView.image = model.icon
        inputTextField.attributedPlaceholder = .init(
            string: model.placeholder,
            attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ])
        inputTextField.isSecureTextEntry = model.isSecureTextEntry
    }

    private func setupUI() {
        backgroundColor = .clear
        containerView.backgroundColor = .white.withAlphaComponent(0.8)
        containerView.layer.cornerRadius = 28
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        iconImageView.contentMode = .scaleAspectFit
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
        }

        inputTextField.attributedText = .init(
            string: "",
            attributes: [
                .foregroundColor: UIColor.Text.header,
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ])
        inputTextField.textAlignment = .left
        inputTextField.addTarget(self, action: #selector(editingAction), for: .editingChanged)
        containerView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }

    @objc
    private func editingAction() {
        onEditingChanged?(inputTextField.text ?? "")
    }

    struct Model {
        let icon: UIImage
        let placeholder: String
        let isSecureTextEntry: Bool
    }
}
