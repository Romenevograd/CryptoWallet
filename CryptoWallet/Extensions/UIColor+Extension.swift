import UIKit

extension UIColor {
    //Основной бэк цвет адаптивный тёмный/светлый
    static var backgroundMain: UIColor {
        return UIColor(named: "Background/main" ) ?? systemBackground
    }
    
    static var backgroundMainLighter: UIColor {
        return UIColor(named: "Background/mainLighter") ?? systemBackground
    }
    //Основной цвет текста светлый/темный
    static var textPrimary: UIColor {
        return UIColor(named: "Text/primary" ) ?? .label
    }
    //Основной бэк хэдера
    static var accentPink: UIColor {
        return UIColor(named: "Background/pink" ) ?? systemPink
    }
    //основной текст цвета в хэдере
    static var textHeader: UIColor {
        return UIColor(named: "Text/header" ) ?? .label
    }
    //Функция осветления
    func lighter(by percentage: CGFloat = 0.3) -> UIColor {
            return self.adjustBrightness(by: abs(percentage))
        }
        
        private func adjustBrightness(by percentage: CGFloat) -> UIColor {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            
            if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                let newBrightness = min(brightness + percentage, 1.0)
                return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
            }
            return self
        }
}
