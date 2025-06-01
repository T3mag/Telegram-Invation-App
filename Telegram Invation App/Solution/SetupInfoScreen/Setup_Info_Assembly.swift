
import UIKit

class SetupInfoAssembly {
    
    static func screenBuilder() -> UIViewController {
        let view = SetupInfoViewController()
        let viewModel = SetupInfoViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        
        return view
    }
    
    
    static func screenBuilderForAdd(link: Link, typeSetup: TypeSetupInfoScreen, delegate: ReloadViewControllerDelegate) -> UIViewController {
        let view = SetupInfoViewController(link: link, typeSetup: typeSetup, delegate: delegate)
        let viewModel = SetupInfoViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        
        return view
    }
    
    static func screenBuilderForLink(typeSetup: TypeSetupInfoScreen,
                                     delegate: SetupInfoViewControllerDelete) -> UIViewController {
        let view = SetupInfoViewController(typeSetup: typeSetup, delegate: delegate)
        let viewModel = SetupInfoViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        
        return view
    }
    
    static func screenBuilderForLink(link: Link) -> UIViewController {
        let view = SetupInfoViewController(link: link, typeSetup: .setupLink)
        let viewModel = SetupInfoViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        
        return view
    }
    
    static func screenBuilderForPropleJoined(peopleJoined: JoinedPeoples) -> UIViewController {
        let view = SetupInfoViewController(joinedPeople: peopleJoined, typeSetup: .setupJoindePeople)
        let viewModel = SetupInfoViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        
        return view
    }

}
