import UIKit
import SnapKit

final class AuthViewController: UIViewController, IAuthViewOutput {
    var presenter: IAuthViewInput?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let robotImageView = UIImageView()
    private let loginButton = UIButton(type: .system)
    private let nameTextField = InputTextField()
    private let passwordTextField = InputTextField()

    private var keyboardObserver: KeyboardObserver?
    private var lastKeyboardHeight: CGFloat = .zero

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObserver()
    }

    func update(with state: AuthState) {
        switch state {
        case let .result(model):
            loginButton.isEnabled = model.isValid
            loginButton.backgroundColor = model.isValid ? .Background.buttonPrimary : .Background.buttonPrimary.withAlphaComponent(0.5)
        case .loading, .error:
            break
        }
    }

    private func setupUI() {
        view.backgroundColor = .Background.grey1
        setupScrollView()
        setupStackView()
        setupRobotImageView()
        setupTextFields()
        setupLoginButton()
        setupTapGesture()
    }

    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .none
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(130)
        }
    }

    private func setupRobotImageView() {
        robotImageView.image = .robot
        robotImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(robotImageView)

        let spacerView = UIView()
        stackView.addArrangedSubview(spacerView)
    }

    private func setupTextFields() {
        nameTextField.update(with: .init(
            icon: .user,
            placeholder: "Auth.Username.placeholder".localized,
            isSecureTextEntry: false
        ))
        nameTextField.onEditingChanged = { [weak self] name in
            self?.presenter?.didNameChanged(name)
        }
        stackView.addArrangedSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        passwordTextField.update(with: .init(
            icon: .password,
            placeholder: "Auth.Password.placeholder".localized,
            isSecureTextEntry: true
        ))
        passwordTextField.onEditingChanged = { [weak self] password in
            self?.presenter?.didPasswordChanged(password)
        }
        stackView.addArrangedSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }

    private func setupLoginButton() {
        loginButton.isEnabled = false
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Auth.Button.Login".localized, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        loginButton.backgroundColor = loginButton.isEnabled ? .Background.buttonPrimary : .Background.buttonPrimary.withAlphaComponent(0.5)
        loginButton.layer.cornerRadius = 28
        stackView.addArrangedSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }

    private func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }

    private func setupKeyboardObserver() {
        keyboardObserver = .init { [weak self] info in
            guard let self else { return }

            UIView.animate(
                withDuration: info.animationDuration,
                delay: .zero,
                options: UIView.AnimationOptions(curve: info.animationCurve)
            ) {
                switch info.event {
                case .willShow:
                    guard self.lastKeyboardHeight == .zero else { return }

                    self.lastKeyboardHeight = info.endFrame.height
                    self.stackView.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().inset(info.endFrame.height + self.view.safeAreaInsets.bottom)
                    }
                case .willHide:
                    self.lastKeyboardHeight = .zero

                    self.stackView.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().inset(130)
                    }
                default:
                    break
                }

                self.view.layoutIfNeeded()
            }
        }
    }

    @objc
    private func tapAction() {
        view.endEditing(true)
    }
}
