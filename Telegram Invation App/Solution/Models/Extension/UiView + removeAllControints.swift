import UIKit

extension UIView {
    
    /// Убирает ВСЕ ограничения, в которых участвует этот view,
    /// как собственные, так и у его супервью.
    func removeAllAutoLayoutConstraints() {
        var view: UIView? = self
        
        // 1) Деактивируем собственные constraints
        NSLayoutConstraint.deactivate(self.constraints)
        
        // 2) Деактивируем constraints из супервью (и выше), где участвует self
        while let current = view {
            let affecting = current.constraints.filter {
                $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
            }
            NSLayoutConstraint.deactivate(affecting)
            view = current.superview
        }
        
        // 3) Выключаем autoresizing‑маску, чтобы в дальнейшем можно было
        //    безопасно добавлять новые Auto Layout ‑ ограничения
        translatesAutoresizingMaskIntoConstraints = false
    }
}
