import UIKit

final class KeyboardObserver {
    enum Event {
        case willShow
        case didShow
        case willHide
        case didHide
        case willChangeFrame
        case didChangeFrame
    }

    struct Info {
        let animationCurve: UIView.AnimationCurve
        let animationDuration: TimeInterval
        let isLocal: Bool
        let beginFrame: CGRect
        let endFrame: CGRect
        let event: Event
    }

    private let changeHandler: (Info) -> Void

    init(changeHandler: @escaping (Info) -> Void) {
        self.changeHandler = changeHandler

        let notifications: [(Notification.Name, Event)] = [
            (UIResponder.keyboardWillShowNotification, .willShow),
            (UIResponder.keyboardDidShowNotification, .didShow),
            (UIResponder.keyboardWillHideNotification, .willHide),
            (UIResponder.keyboardDidHideNotification, .didHide),
            (UIResponder.keyboardWillChangeFrameNotification, .willChangeFrame),
            (UIResponder.keyboardDidChangeFrameNotification, .didChangeFrame)
        ]

        notifications.forEach { name, event in
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardChanged),
                name: name,
                object: nil
            )
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        let event = mapEvent(from: notification.name)
        let info = Info(event: event, userInfo: userInfo)
        changeHandler(info)
    }

    private func mapEvent(from notificationName: Notification.Name) -> Event {
        switch notificationName {
        case UIResponder.keyboardWillShowNotification: .willShow
        case UIResponder.keyboardDidShowNotification: .didShow
        case UIResponder.keyboardWillHideNotification: .willHide
        case UIResponder.keyboardDidHideNotification: .didHide
        case UIResponder.keyboardWillChangeFrameNotification: .willChangeFrame
        case UIResponder.keyboardDidChangeFrameNotification: .didChangeFrame
        default: .didHide
        }
    }
}

private extension KeyboardObserver.Info {
    init(event: KeyboardObserver.Event, userInfo: [AnyHashable: Any]) {
        self.event = event

        animationCurve = {
            let rawValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? UIView.AnimationCurve.easeInOut.rawValue
            return UIView.AnimationCurve(rawValue: rawValue) ?? .easeInOut
        }()

        animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool ?? true
        beginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect ?? .zero
        endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
    }
}

extension UIView.AnimationOptions {
    init(curve: UIView.AnimationCurve) {
        switch curve {
        case .easeIn: self = .curveEaseIn
        case .easeOut: self = .curveEaseOut
        case .easeInOut: self = .curveEaseInOut
        case .linear: self = .curveLinear
        @unknown default: self = .curveEaseInOut
        }
    }
}
