import UIKit

class Authentication_Assembly {
    static func screenBuilder() -> UIViewController {
        let view = AuthenticationViewController()
        let viewModel = AuthenticationViewModel()
        
        view.viewModel = viewModel
        
        viewModel.view = view
        
        return view
    }
}
