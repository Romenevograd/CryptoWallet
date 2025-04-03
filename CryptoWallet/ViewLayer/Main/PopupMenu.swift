import SnapKit
import UIKit

protocol PopupMenuDelegate: AnyObject {
    func didSelectFirstAction()
    func didSelectSecondAction()
}

final class PopupMenuView: UIView {
    weak var delegate: PopupMenuDelegate?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
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
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
            
        addSubview(stackView)
        stackView.addArrangedSubview(refreshButton)
        stackView.addArrangedSubview(exitButton)
                
        stackView.snp.makeConstraints {
        $0.edges.equalToSuperview().inset(12)
                }
                
        refreshButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(secondAction), for: .touchUpInside)
    }
    
    @objc private func firstAction() {
            delegate?.didSelectFirstAction()
        }
        
        @objc private func secondAction() {
            delegate?.didSelectSecondAction()
        }
}
