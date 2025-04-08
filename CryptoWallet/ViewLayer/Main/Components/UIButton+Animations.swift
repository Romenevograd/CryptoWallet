import UIKit

extension UIButton {
    func animateTap(scale: CGFloat = 0.95, duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration) {
            self.transform = .init(scaleX: scale, y: scale)
        } completion: { _ in
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            }
        }
    }
}
