import UIKit

protocol InvationLinkHeaderDelegate: AnyObject {
    func opeSetingView(type: TypeSetupInfoScreen)
    func addNewPeople()
    func closeScreen()
}

final class invationLinksTableHeader: UIView {
    
    var delegateHeader: InvationLinkHeaderDelegate?
    
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изм.", for: .normal)
        button.setTitleColor(Colors.lightBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        let action = UIAction { [weak self] _ in
            self?.delegateHeader?.addNewPeople()
        }
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(Colors.lightBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        
        let action = UIAction { [weak self] _ in
            self?.delegateHeader?.closeScreen()
        }
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    /// Задний фон основной пригласительной ссылкой
    lazy var backgroundInvationLinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.lightBlack
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    /// Основная пригласительная ссылка
    lazy var invationLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19)
        let attributedText = NSAttributedString(
            string: "t.me/+vOce-vXTHHdjNTk6",
            attributes: [
                .kern: -0.3, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 19),
                .foregroundColor: UIColor.white
            ]
        )
        label.attributedText = attributedText
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// Кнопка настроек основной пригласительной ссылки
    lazy var invationSettingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.elipsisCircleFillImage, for: .normal)
        button.tintColor = Colors.light2Gray
        
        let action = UIAction { [weak self] _ in
            self?.delegateHeader?.opeSetingView(type: .setupLinkView)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    /// Кнопка "Копировать"
    lazy var copyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.lightBlue
        button.layer.cornerRadius = 12
        button.setTitle("Копировать", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    /// Кнопка "Поделиться"
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.lightBlue
        button.layer.cornerRadius = 12
        button.setTitle("Поделиться", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        backgroundColor = Colors.darkGray
        addSubview(updateButton)
        addSubview(titleLabel)
        addSubview(completeButton)
        
        addSubview(backgroundInvationLinkView)
        addSubview(invationLinkLabel)
        addSubview(invationSettingsButton)
        addSubview(copyButton)
        addSubview(shareButton)
        
        
        NSLayoutConstraint.activate([
            updateButton.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor),
            updateButton.leadingAnchor.constraint(
                equalTo: backgroundInvationLinkView.leadingAnchor),
            
            titleLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            completeButton.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor, constant: 2),
            completeButton.trailingAnchor.constraint(
                equalTo: backgroundInvationLinkView.trailingAnchor, constant: 1),
            
            // Настройка позиции и размеров для backgroundInvationLinkView
            backgroundInvationLinkView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 37),
            backgroundInvationLinkView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 19),
            backgroundInvationLinkView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -19),
            backgroundInvationLinkView.heightAnchor.constraint(
                equalToConstant: 55),
            
            // Настройка позиции и размеров для invationLinkLabel
            invationLinkLabel.centerYAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerYAnchor),
            invationLinkLabel.centerXAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerXAnchor),
            
            // Настройка позиции и размеров для invationSettingsButton
            invationSettingsButton.centerYAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerYAnchor),
            invationSettingsButton.trailingAnchor.constraint(
                equalTo: backgroundInvationLinkView.trailingAnchor),
            invationSettingsButton.heightAnchor.constraint(equalToConstant: 54),
            invationSettingsButton.widthAnchor.constraint(equalToConstant: 54),
            
            // Настройка позиции и размеров для copyButton
            copyButton.topAnchor.constraint(
                equalTo: backgroundInvationLinkView.bottomAnchor, constant: 17),
            copyButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            copyButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -4),
            copyButton.heightAnchor.constraint(equalToConstant: 55),

            // Настройка позиции и размеров для shareButton
            shareButton.topAnchor.constraint(
                equalTo: backgroundInvationLinkView.bottomAnchor, constant: 17),
            shareButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),
            shareButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 4),
            shareButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
}
