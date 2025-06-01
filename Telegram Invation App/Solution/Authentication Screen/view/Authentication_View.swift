
import UIKit

class AuthenticationView: UIView {
    
    private var typeAuthentication: typeAuthentication?
    var viewController: AuthenticationViewController?
    
    /// TextField для ввода номера телефона
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        textField.keyboardType = .numbersAndPunctuation
        textField.delegate = self
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Номер телефона с +",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }()

    // TextField для ввода кода и пароля
    lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.delegate = self
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод настройки CodeTextField
    func setupCodeTextField(type: typeAuthentication) {
        
        typeAuthentication = type
        
        DispatchQueue.main.sync {
            self.codeTextField.text = ""
            
            switch type {
            case .waitTelegramCode:
                self.codeTextField.attributedPlaceholder = NSAttributedString(
                    string: "Жду телеграм код",
                    attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
                )
            case .waitPassword:
                self.codeTextField.attributedPlaceholder = NSAttributedString(
                    string: "Жду пароль 2FA",
                    attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
                )
            }
            
            self.addSubview(self.codeTextField)
            
            NSLayoutConstraint.activate([
                self.codeTextField.topAnchor.constraint(
                    equalTo: self.numberTextField.bottomAnchor, constant: 20),
                self.codeTextField.leadingAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                self.codeTextField.trailingAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                self.codeTextField.heightAnchor.constraint(
                    equalToConstant: 40),
            ])
        }
    }
    
    // Настройка UI
    func setupLayout() {
        addSubview(numberTextField)
        
        NSLayoutConstraint.activate([
            
            numberTextField.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor),
            numberTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            numberTextField.heightAnchor.constraint(
                equalToConstant: 40),
        ])
        
    }
}

// Расширение для настройки делегата у TextField
extension AuthenticationView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            viewController?.setAuthenticationNumber(number: numberTextField.text ?? "")
            return true
        }
        
        if textField.tag == 1 {
            viewController?.setAuthenticationCode(code: textField.text ?? "",
                                                  typeAuthentication: typeAuthentication ?? .waitTelegramCode)
            return true
        }
        
        return false
    }
}
