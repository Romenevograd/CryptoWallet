import UIKit
import SnapKit

final class LoadingView: UIView {
    private let containerView = UIView()
    private let activityView = UIActivityIndicatorView()

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    private func setupUI() {
        backgroundColor = .clear
        containerView.backgroundColor = .gray.withAlphaComponent(0.3)

        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityView.style = .large
        activityView.color = .accentPink
        activityView.startAnimating()

        containerView.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
