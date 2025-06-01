
import UIKit

class SetupInfoView: UIView {
    
    var typeSetup: TypeSetupInfoScreen?
    var viewController: SetupInfoViewController?
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(Colors.lightBlue, for: .normal)
        button.backgroundColor = .clear
        
        let action = UIAction { [weak self] _ in
            switch self?.typeSetup {
            case .setupLink:
                let newTitle = self?.firstTextField.text
                let newDescription = self?.secondTextField.text
                self?.viewController?.updateLinkInfo(newTitle: newTitle ?? "",
                                                     newDescription: newDescription ?? "")
            case .setupJoindePeople:
                let newName = self?.firstTextField.text
                let newDate = self?.secondTextField.text
                let accentColorID = self?.thirdTextField.text ?? ""
                let photoPath = self?.FirdTextField.text ?? ""
                let emojiPath = self?.fithTextField.text ?? ""
                self?.viewController?.updatePeopleJoined(newName: newName ?? "",
                                                         newDate: newDate ?? "",
                                                         accentColorID: accentColorID,
                                                         photoPath: photoPath,
                                                         emojiPath: emojiPath)
            case .setupLinkViewAndNumberOfJoined:
                let link = self?.firstTextField.text ?? "Ошибка"
                let countes = self?.secondTextField.text ?? ""
                let peoples = self?.thirdTextField.text ?? ""
                self?.viewController?.updateLinkAndPhotoJoined(link: link,
                                                               countPeople: countes,
                                                               peoplesName: peoples)
            case .setupLinkView:
                let link = self?.firstTextField.text ?? "Ошибка"
                self?.viewController?.updateLinkAndPhotoJoined(link: link,
                                                               countPeople: "",
                                                               peoplesName: "")
            case .addNewPeople:
                let peoples = self?.firstTextField.text ?? ""
                let dates = self?.secondTextField.text ?? ""
                self?.viewController?.createNewPeoples(peoplesName: peoples, datesList: dates)
            case .none:
                print("Тык")
            default:
                print("{p")
            }
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Редактирование"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var firstTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новый title",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var secondTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новый description",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var thirdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новый description",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var FirdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новый description",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var fithTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.darkGray
        textField.layer.cornerRadius = 10
        textField.textColor = Colors.light1Gray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новый description",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupOneTextField(text: String) {
        firstTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        addSubview(firstTextField)
        
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(
                equalTo: completeButton.bottomAnchor, constant: 10),
            firstTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            firstTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            firstTextField.heightAnchor.constraint(
                equalToConstant: 40),
        ])
    }
    
    func setupTwoTextField(text: String) {
        secondTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        addSubview(secondTextField)
        
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(
                equalTo: firstTextField.bottomAnchor, constant: 10),
            secondTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            secondTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            secondTextField.heightAnchor.constraint(
                equalToConstant: 40)
        ])
    }
    
    func setupThreeTextField(text: String) {
        thirdTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        addSubview(thirdTextField)
        
        NSLayoutConstraint.activate([
            thirdTextField.topAnchor.constraint(
                equalTo: secondTextField.bottomAnchor, constant: 10),
            thirdTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            thirdTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            thirdTextField.heightAnchor.constraint(
                equalToConstant: 40),
        ])
    }
    
    func setupTherdTextField(text: String) {
        FirdTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        addSubview(FirdTextField)
        
        NSLayoutConstraint.activate([
            FirdTextField.topAnchor.constraint(
                equalTo: thirdTextField.bottomAnchor, constant: 10),
            FirdTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            FirdTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            FirdTextField.heightAnchor.constraint(
                equalToConstant: 40),
        ])
    }
    
    func setupFithTextField(text: String) {
        fithTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.light1Gray]
        )
        
        addSubview(fithTextField)
        
        NSLayoutConstraint.activate([
            fithTextField.topAnchor.constraint(
                equalTo: FirdTextField.bottomAnchor, constant: 10),
            fithTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            fithTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            fithTextField.heightAnchor.constraint(
                equalToConstant: 40),
        ])
    }
    
    func setupLayout() {
        backgroundColor = .black
        
        addSubview(titleLabel)
        addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(
                equalTo: completeButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            completeButton.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
}
