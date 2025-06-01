//
//  CellHeaderView.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 09.05.2025.
//

import UIKit

class CellHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSAttributedString(
            string: "ССЫЛКА СОЗДАНА",
            attributes: [
                .kern: +0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.white
            ]
        )
        label.attributedText = attributedText

        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title.uppercased()
        setupLayout()
    }
    
    func setupLayout() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 18)
        ])
    }
}
