import UIKit

final class InvationLinksInfoAssembly {
    
    static func screenBuilder(link: Link) -> UIViewController {
        let view = InvationLinksInfoViewController(link: link)
        let viewModel = InvationLinksInfoViewModel()
        
        view.viewModel = viewModel
        
        viewModel.view = view
        
        return view
    }
}

