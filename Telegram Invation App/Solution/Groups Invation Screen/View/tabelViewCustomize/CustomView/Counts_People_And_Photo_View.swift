//
//  Counts_People_And_Photo_View.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 14.05.2025.
//

import UIKit

class CountsPeopleAndPhotoView: UIView {

    /// Надпись с информацией о кол-ве присоеденившихся
    lazy var numberOfPeopleJoinedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = Colors.light1Gray
        label.text = "никто пока не присоеденился"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var oneImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Colors.darkGray.cgColor
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Colors.darkGray.cgColor
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Colors.darkGray.cgColor
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(peoplePhotoPath: [AvatarInfo], countPeoples: String) {
        
        if peoplePhotoPath.count <= 0 {
            let attributedText = NSAttributedString(
                string: countPeoples.setupCountString(),
                attributes: [
                    .kern: +0.5, // уменьшает расстояние между символами
                    .font: UIFont.systemFont(ofSize: 15),
                    .foregroundColor: Colors.light1Gray
                ]
            )
            numberOfPeopleJoinedLabel.attributedText = attributedText
        } else {
            let attributedText = NSAttributedString(
                string: countPeoples.setupCountString(),
                attributes: [
                    .kern: +0.3, // уменьшает расстояние между символами
                    .font: UIFont.systemFont(ofSize: 18),
                    .foregroundColor: Colors.lightBlue
                ]
            )
            numberOfPeopleJoinedLabel.attributedText = attributedText
        }
        
        if peoplePhotoPath.count <= 0 {
            numberOfPeopleJoinedLabel.text = "никто пока не присоеденился"
            
            addSubview(numberOfPeopleJoinedLabel)
            
            NSLayoutConstraint.activate([
                // Настройка позиции и размеров для numberOfPeopleJoinedLabel
                numberOfPeopleJoinedLabel.centerXAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.centerXAnchor),
                numberOfPeopleJoinedLabel.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                numberOfPeopleJoinedLabel.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            ])
            
        } else if peoplePhotoPath.count == 1 {
            
            if peoplePhotoPath[0].photoPath != nil {
                oneImageView.image = UIImage(contentsOfFile: peoplePhotoPath[0].photoPath ?? "")
            } else {
                oneImageView.setCirclePlaceholder(text: peoplePhotoPath[0].title ?? "", accentColorId: peoplePhotoPath[0].accentColor ?? 0)
            }
            
            numberOfPeopleJoinedLabel.textColor = Colors.lightBlue
            
            addSubview(oneImageView)
            addSubview(numberOfPeopleJoinedLabel)
            
            NSLayoutConstraint.activate([
                oneImageView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor),
                oneImageView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor),
                oneImageView.leadingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.leadingAnchor, constant: -2),
                oneImageView.heightAnchor.constraint(equalToConstant: 40),
                oneImageView.widthAnchor.constraint(equalToConstant: 40),
                
                numberOfPeopleJoinedLabel.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                numberOfPeopleJoinedLabel.leadingAnchor.constraint(
                    equalTo: oneImageView.trailingAnchor, constant: 20),
                numberOfPeopleJoinedLabel.trailingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
            
        } else if peoplePhotoPath.count == 2 {
            if peoplePhotoPath[0].photoPath != nil {
                oneImageView.image = UIImage(contentsOfFile: peoplePhotoPath[0].photoPath ?? "")
            } else {
                oneImageView.setCirclePlaceholder(text: peoplePhotoPath[0].title ?? "", accentColorId: peoplePhotoPath[0].accentColor ?? 0)
            }
            
            if peoplePhotoPath[1].photoPath != nil {
                twoImageView.image = UIImage(contentsOfFile: peoplePhotoPath[1].photoPath ?? "")
            } else {
                twoImageView.setCirclePlaceholder(text: peoplePhotoPath[1].title ?? "", accentColorId: peoplePhotoPath[1].accentColor ?? 0)
            }
            
            numberOfPeopleJoinedLabel.textColor = Colors.lightBlue
            
            addSubview(twoImageView)
            addSubview(oneImageView)
            addSubview(numberOfPeopleJoinedLabel)
            
            NSLayoutConstraint.activate([
                oneImageView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor),
                oneImageView.leadingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.leadingAnchor),
                oneImageView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor),
                oneImageView.heightAnchor.constraint(equalToConstant: 40),
                oneImageView.widthAnchor.constraint(equalToConstant: 40),
                
                twoImageView.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                twoImageView.leadingAnchor.constraint(
                    equalTo: oneImageView.centerXAnchor, constant: 5),
                twoImageView.heightAnchor.constraint(equalToConstant: 40),
                twoImageView.widthAnchor.constraint(equalToConstant: 40),
                
                numberOfPeopleJoinedLabel.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                numberOfPeopleJoinedLabel.leadingAnchor.constraint(
                    equalTo: twoImageView.trailingAnchor, constant: 20),
                numberOfPeopleJoinedLabel.trailingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
            
        } else if peoplePhotoPath.count >= 3 {
            if peoplePhotoPath[0].photoPath != nil {
                oneImageView.image = UIImage(contentsOfFile: peoplePhotoPath[0].photoPath ?? "")
            } else {
                oneImageView.setCirclePlaceholder(text: peoplePhotoPath[0].title ?? "", accentColorId: peoplePhotoPath[0].accentColor ?? 0)
            }
            
            if peoplePhotoPath[1].photoPath != nil {
                twoImageView.image = UIImage(contentsOfFile: peoplePhotoPath[1].photoPath ?? "")
            } else {
                oneImageView.setCirclePlaceholder(text: peoplePhotoPath[1].title ?? "", accentColorId: peoplePhotoPath[1].accentColor ?? 0)
            }
            
            if peoplePhotoPath[2].photoPath != nil {
                threeImageView.image = UIImage(contentsOfFile: peoplePhotoPath[2].photoPath ?? "")
            } else {
                oneImageView.setCirclePlaceholder(text: peoplePhotoPath[2].title ?? "", accentColorId: peoplePhotoPath[2].accentColor ?? 0)
            }
            
            numberOfPeopleJoinedLabel.textColor = Colors.lightBlue
            
            addSubview(oneImageView)
            addSubview(twoImageView)
            addSubview(threeImageView)
            addSubview(numberOfPeopleJoinedLabel)
            
            NSLayoutConstraint.activate([
                oneImageView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor),
                oneImageView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor),
                oneImageView.leadingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.leadingAnchor),
                oneImageView.heightAnchor.constraint(equalToConstant: 35),
                oneImageView.widthAnchor.constraint(equalToConstant: 40),
                
                twoImageView.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                twoImageView.leadingAnchor.constraint(
                    equalTo: oneImageView.centerXAnchor, constant: 5),
                twoImageView.heightAnchor.constraint(equalToConstant: 35),
                twoImageView.widthAnchor.constraint(equalToConstant: 40),
                
                threeImageView.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                threeImageView.leadingAnchor.constraint(
                    equalTo: twoImageView.centerXAnchor, constant: 5),
                threeImageView.heightAnchor.constraint(equalToConstant: 35),
                threeImageView.widthAnchor.constraint(equalToConstant: 40),
                
                numberOfPeopleJoinedLabel.centerYAnchor.constraint(
                    equalTo: oneImageView.centerYAnchor),
                numberOfPeopleJoinedLabel.leadingAnchor.constraint(
                    equalTo: threeImageView.trailingAnchor, constant: 22),
                numberOfPeopleJoinedLabel.trailingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.trailingAnchor),
            ])
        }
    }
}
