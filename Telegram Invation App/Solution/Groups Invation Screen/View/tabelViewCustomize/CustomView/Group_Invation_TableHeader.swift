import UIKit

protocol GroupInavtionViewDelegate: AnyObject {
    func openSetingsView(type: TypeSetupInfoScreen)
}

class GroupInvationTableHeadView: UIView {
    
    var delegate: GroupInavtionViewDelegate?
    
    /// Видео с утенком
    lazy var telegramDuckVideoView: DuckVideoView = {
        let view = DuckVideoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    /// Надпись под Gif c утенком
    lazy var telegramInvationMainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSAttributedString(
            string: "Любой пользователь Telegram сможет подписаться на канал при помощи этой ссылки.",
            attributes: [
                .kern: +0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: Colors.light1Gray,
            ]
        )
        label.attributedText = attributedText
        
        label.numberOfLines = 5
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    /// Надпись перед блоком с основной пригласительной ссылкой
    lazy var titleAboveTheInvationBlockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        let attributedText = NSAttributedString(
            string: "ССЫЛКА-ПРИГЛАШЕНИЕ",
            attributes: [
                .kern: -0.4, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: Colors.light1Gray
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    /// Задний фон для блока с основной пригласительной ссылкой
    lazy var backgroundInvationBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.darkGray
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
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
        label.isUserInteractionEnabled = false
        
        let attributedText = NSAttributedString(
            string: "t.me/+vOce-vXTHHdjNTk6",
            attributes: [
                .kern: +0.5, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 18),
                .foregroundColor: UIColor.white
            ]
        )
        label.attributedText = attributedText
        
        return label
    }()
    
    /// Кнопка настроек основной пригласительной ссылки
    lazy var invationSettingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.elipsisCircleFillImage, for: .normal)
        button.tintColor = Colors.light2Gray
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.openSetingsView(type: .setupLinkViewAndNumberOfJoined)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    /// Кнопка "Копировать"
    lazy var copyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.lightBlue
        button.layer.cornerRadius = 13
        button.setTitle("Копировать", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    /// Кнопка "Поделиться"
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.lightBlue
        button.layer.cornerRadius = 13
        button.setTitle("Поделиться", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
        // "Верхний блок"
        addSubview(telegramDuckVideoView)
        addSubview(telegramInvationMainLabel)
        
        // "Центральный блок"
        addSubview(titleAboveTheInvationBlockLabel)
        addSubview(backgroundInvationBlockView)
        addSubview(backgroundInvationLinkView)
        addSubview(invationLinkLabel)
        addSubview(invationSettingsButton)
        addSubview(copyButton)
        addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            // Настройка позиции и размеров для telegramDuckVideoView
            telegramDuckVideoView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            telegramDuckVideoView.topAnchor.constraint(equalTo: topAnchor,
                                                       constant: 15),
            telegramDuckVideoView.widthAnchor.constraint(equalToConstant: 145),
            telegramDuckVideoView.heightAnchor.constraint(equalToConstant: 150),
            
            // Настройка позиции и размеров для telegramInvationMainLabel
            telegramInvationMainLabel.topAnchor.constraint(
                equalTo: telegramDuckVideoView.bottomAnchor, constant: 4),
            telegramInvationMainLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 30),
            telegramInvationMainLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -30),
            
            // Настройка позиции и размеров для titleAboveTheInvationBlockLabel
            titleAboveTheInvationBlockLabel.topAnchor.constraint(
                equalTo: telegramInvationMainLabel.bottomAnchor, constant: 30),
            titleAboveTheInvationBlockLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 17),
            
            // Настройка позиции и размеров для backgroundInvationBlockView
            backgroundInvationBlockView.topAnchor.constraint(
                equalTo: titleAboveTheInvationBlockLabel.bottomAnchor, constant: 7),
            backgroundInvationBlockView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            backgroundInvationBlockView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            
            // Настройка позиции и размеров для backgroundInvationLinkView
            backgroundInvationLinkView.topAnchor.constraint(
                equalTo: backgroundInvationBlockView.topAnchor, constant: 17),
            backgroundInvationLinkView.leadingAnchor.constraint(
                equalTo: backgroundInvationBlockView.leadingAnchor, constant: 18),
            backgroundInvationLinkView.trailingAnchor.constraint(
                equalTo: backgroundInvationBlockView.trailingAnchor, constant: -18),
            backgroundInvationLinkView.heightAnchor.constraint(
                equalToConstant: 57),
            
            // Настройка позиции и размеров для invationLinkLabel
            invationLinkLabel.centerYAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerYAnchor),
            invationLinkLabel.centerXAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerXAnchor),
            
            // Настройка позиции и размеров для invationSettingsButton
            invationSettingsButton.centerYAnchor.constraint(
                equalTo: backgroundInvationLinkView.centerYAnchor),
            invationSettingsButton.trailingAnchor.constraint(
                equalTo: backgroundInvationLinkView.trailingAnchor, constant: -8),
            invationSettingsButton.heightAnchor.constraint(equalToConstant: 45),
            invationSettingsButton.widthAnchor.constraint(equalToConstant: 45),
            
            // Настройка позиции и размеров для copyButton
            copyButton.topAnchor.constraint(
                equalTo: backgroundInvationLinkView.bottomAnchor, constant: 17),
            copyButton.leadingAnchor.constraint(
                equalTo: backgroundInvationBlockView.leadingAnchor, constant: 18),
            copyButton.trailingAnchor.constraint(
                equalTo: backgroundInvationBlockView.centerXAnchor, constant: -4),
            copyButton.heightAnchor.constraint(equalToConstant: 56),
            
            // Настройка позиции и размеров для shareButton
            shareButton.topAnchor.constraint(
                equalTo: backgroundInvationLinkView.bottomAnchor, constant: 17),
            shareButton.trailingAnchor.constraint(
                equalTo: backgroundInvationBlockView.trailingAnchor, constant: -18),
            shareButton.leadingAnchor.constraint(
                equalTo: backgroundInvationBlockView.centerXAnchor, constant: 4),
            shareButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupCountOfPeopleAndPhoto(peoplePhotoPath: [AvatarInfo], countPeoples: String) {
        let photoAndPeopleCountsView = CountsPeopleAndPhotoView()
        photoAndPeopleCountsView.translatesAutoresizingMaskIntoConstraints = false
        photoAndPeopleCountsView.setupLayout(peoplePhotoPath: peoplePhotoPath, countPeoples: countPeoples)
        
        addSubview(photoAndPeopleCountsView)
        
        NSLayoutConstraint.activate([
            photoAndPeopleCountsView.topAnchor.constraint(
                equalTo: shareButton.bottomAnchor, constant: 18),
            photoAndPeopleCountsView.bottomAnchor.constraint(
                equalTo: backgroundInvationBlockView.bottomAnchor, constant: -18),
            photoAndPeopleCountsView.centerXAnchor.constraint(
                equalTo: backgroundInvationBlockView.centerXAnchor)
        ])
    }
    
}
