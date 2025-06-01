import UIKit
import Combine

/// Протокол через который мы получаем доступ в внутрь GroupInvationViewModel
protocol AuthenticationViewModelInput: AnyObject {
    func setupBindings()
    func setAuthenticationNumber(number: String)
    func setAuthenticationCode(code: String, typeAuthentication: typeAuthentication )
}
/// Протокол позволяет получить доступ к view, но только к указаным функциям
protocol AuthenticationViewModelOutput: AnyObject {
    func setupSecondTextField(type: typeAuthentication)
    func presentGroupInvationLinksScreen()
}

class AuthenticationViewModel: AuthenticationViewModelInput {
    
    weak var view: AuthenticationViewModelOutput?

    private let tDLibController = TelegramTDLibController.shared
    private var cancellables = Set<AnyCancellable>()
    
    func setupBindings() {
        tDLibController.$authorizationState.sink { authorisationState in
            switch authorisationState {
                
            case .authorizationStateWaitCode(_):
                self.view?.setupSecondTextField(type: .waitTelegramCode)
                
            case .authorizationStateWaitPassword(_):
                self.view?.setupSecondTextField(type: .waitPassword )
                
            case .authorizationStateReady:
                self.view?.presentGroupInvationLinksScreen()
            
            case .authorizationStateClosed:
                print("Close")
            case .authorizationStateClosing:
                print("Closing")
            case .authorizationStateLoggingOut:
                print("log out")
            default:
                print("Не обработанные состояния => \(authorisationState)")
            }
        }.store(in: &cancellables)
    }
    
    func setAuthenticationNumber(number: String) {
        tDLibController.asyncSetAuthenticationNumber(number: number)
    }
    
    func setAuthenticationCode(code: String, typeAuthentication: typeAuthentication ) {
        switch typeAuthentication {
        case.waitTelegramCode:
            tDLibController.asyncSetAuthenticationCode(code: code)
        case.waitPassword:
            tDLibController.asyncSetAuthenticationPassword(password: code)
        }
    }
}
