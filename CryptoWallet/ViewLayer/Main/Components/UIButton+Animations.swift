import UIKit

extension UIButton {
    /// Анимация нажатия кнопки с эффектом масштабирования
    /// - Parameters:
    ///   - scale: Коэффициент масштабирования (по умолчанию 0.95)
    ///   - duration: Длительность анимации (по умолчанию 0.2 секунды)
    ///   - damping: Эффект пружины (от 0 до 1)
    ///   - velocity: Начальная скорость анимации
    func animateTap(scale: CGFloat = 0.95,
                   duration: TimeInterval = 0.2,
                   damping: CGFloat = 0.4,
                   velocity: CGFloat = 0.5) {
        // Отключаем взаимодействие на время анимации
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.alpha = 0.9
        }, completion: { _ in
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: velocity,
                           options: [.allowUserInteraction],
                           animations: {
                self.transform = .identity
                self.alpha = 1.0
            }, completion: { _ in
                self.isUserInteractionEnabled = true
            })
        })
    }
    
    /// Анимация "пульсации" (увеличение с прозрачностью)
    func animatePulse(duration: TimeInterval = 0.6) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = 1.0
        pulse.toValue = 1.12
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        
        layer.add(pulse, forKey: "pulse")
    }
    
    /// Анимация изменения цвета фона
    func animateBackgroundColor(to color: UIColor, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.backgroundColor = color
        }
    }
    
    /// Комбинированная анимация (масштаб + цвет)
    func animateTapWithColor(scale: CGFloat = 0.95,
                            highlightColor: UIColor,
                            originalColor: UIColor,
                            duration: TimeInterval = 0.2) {
        animateTap(scale: scale, duration: duration)
        animateBackgroundColor(to: highlightColor, duration: duration/2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration/2) {
            self.animateBackgroundColor(to: originalColor, duration: duration/2)
        }
    }
}
