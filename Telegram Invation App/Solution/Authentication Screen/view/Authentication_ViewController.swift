
import UIKit

class AuthenticationViewController: UIViewController, AuthenticationViewModelOutput {

    var viewModel: AuthenticationViewModelInput?
    private let contentView: AuthenticationView = .init()
    
    override func loadView() {
        viewModel?.setupBindings()
        contentView.viewController = self
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setAuthenticationNumber(number: String) {
        viewModel?.setAuthenticationNumber(number: number)
    }
    
    func setAuthenticationCode(code: String, typeAuthentication: typeAuthentication ) {
        viewModel?.setAuthenticationCode(code: code, typeAuthentication: typeAuthentication)
    }
    
    func presentGroupInvationLinksScreen() {
        DispatchQueue.main.async {
            let viewController = GroupInvationAssembly.screenBuilder()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func setupSecondTextField(type: typeAuthentication) {
        contentView.setupCodeTextField(type: type)
        
        DispatchQueue.main.async {
            self.view.reloadInputViews()
        }
    }
}
