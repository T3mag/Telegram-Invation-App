//
//  peopleJoinedByLinksTableViewCell.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 09.05.2025.
//

import UIKit

class PeopleJoinedByLinksTableViewCell: UITableViewCell {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var emojiStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "T3mag (Артур)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 апр. 2025 в 20:45"
        let attributedText = NSAttributedString(
            string: "ССЫЛКА СОЗДАНА",
            attributes: [
                .kern: +0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: Colors.light1Gray
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var seporationLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(red: 10/256, green: 10/256, blue: 10/256, alpha: 1.0))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMainCell(name: String, date: String, accentColorId: Int, photoPath: String, emojiPath: String) {
        nameLabel.text = name
        dateLabel.text = date
        avatarImageView.image = UIImage(named: "logoCreator")
        
        if emojiPath != "" {
            emojiStatusImageView.image = UIImage(contentsOfFile: emojiPath)
            addSubview(emojiStatusImageView)
            
            NSLayoutConstraint.activate([
                emojiStatusImageView.topAnchor.constraint(
                    equalTo: nameLabel.topAnchor),
                emojiStatusImageView.bottomAnchor.constraint(
                    equalTo: nameLabel.bottomAnchor),
                emojiStatusImageView.heightAnchor.constraint(
                    equalToConstant: 18),
                emojiStatusImageView.leadingAnchor.constraint(
                    equalTo: nameLabel.trailingAnchor, constant: 7),
            ])
        }
    }
    
    func configure(peopleJoind: JoinedPeoples) {
        nameLabel.text = peopleJoind.name
        dateLabel.text = peopleJoind.dateJoined
        
        if peopleJoind.photoPath == "" {
            avatarImageView.setCirclePlaceholder(text: peopleJoind.name ?? "", accentColorId: Int(peopleJoind.accentColorID))
        } else {
            avatarImageView.image = UIImage(contentsOfFile: peopleJoind.photoPath ?? "")
        }
        
        if peopleJoind.emojiPath != "" {
            let image = UIImage(contentsOfFile: peopleJoind.emojiPath ?? "")
            
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            guard let img = imageView.image,
                  let width  = img.size.width as CGFloat?,
                  let height = img.size.height as CGFloat? else {
                // Обработка случая, когда image == nil
                return
            }

            // Теперь width и height — обычные CGFloat
            let aspectRatio = width / height

            // 1) Фиксированная высота 20 pt
            let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 20)
            heightConstraint.isActive = true

            // 2) Соотношение сторон: width = height * aspectRatio
            let widthConstraint = imageView.widthAnchor.constraint(
                equalTo: imageView.heightAnchor,
                multiplier: aspectRatio
            )
            widthConstraint.isActive = true
            
            addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
                imageView.leadingAnchor.constraint(
                    equalTo: nameLabel.trailingAnchor, constant: 5),
            ])
        }
    }
    
    func setupLayout() {
        
        backgroundColor = .black
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.selectedGray
        selectedBackgroundView = bgColorView
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(seporationLineView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            avatarImageView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            avatarImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            avatarImageView.widthAnchor.constraint(
                equalToConstant: 45),
            avatarImageView.heightAnchor.constraint(
                equalToConstant: 45),
            
            nameLabel.centerYAnchor.constraint(
                equalTo: avatarImageView.centerYAnchor, constant: -13),
            nameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor, constant: 12),
            
            dateLabel.centerYAnchor.constraint(
                equalTo: avatarImageView.centerYAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            
            seporationLineView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            seporationLineView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            seporationLineView.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor),
            seporationLineView.heightAnchor.constraint(
                equalToConstant: 2)
        ])
        
    }
}
