import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private lazy var mainView = MainView(delegate: self)

    private var popoverController: UIViewController?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool { true }

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func showActionMenu() {
        let popoverController = UIViewController()
        popoverController.view.backgroundColor = .clear
        popoverController.modalPresentationStyle = .popover

        let menuView = ActionMenuView(delegate: self)
        menuView.backgroundColor = .backgroundMain
        popoverController.view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let fittingSize = menuView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        popoverController.preferredContentSize = fittingSize

        let popover = popoverController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = mainView.headerView.moreButton
        popover?.sourceRect = mainView.headerView.moreButton.bounds
        popover?.permittedArrowDirections = []
        popover?.backgroundColor = .clear

        present(popoverController, animated: true)

        self.popoverController = popoverController
    }
}

extension MainViewController: MainViewDelegate {
    func didSelectActionMenu() {
        showActionMenu()
    }
}

extension MainViewController: ActionMenuViewDelegate {
    func didSelectRefreshAction() {
        popoverController?.dismiss(animated: true)
    }
    
    func didSelectExitAction() {
        popoverController?.dismiss(animated: true)
    }
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
