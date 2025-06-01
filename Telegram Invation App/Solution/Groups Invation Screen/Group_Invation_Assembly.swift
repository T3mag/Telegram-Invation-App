import UIKit

final class GroupInvationAssembly {
    
    /// Сборщик экрана.
    /// Он нужен чтобы настрить все зависимости и дать готовый экран
    static func screenBuilder() -> UIViewController {
        let view = GroupInavtionViewController()
        let viewModel = GroupInvationViewModel()
        
        view.viewModel = viewModel
        
        viewModel.view = view
        
        return view
    }
}

