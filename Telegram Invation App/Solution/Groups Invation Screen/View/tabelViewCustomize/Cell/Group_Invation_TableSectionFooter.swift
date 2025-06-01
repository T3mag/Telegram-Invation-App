
import UIKit

class GroupInvationTableFooter: UIView {
    
    /// Информация о дополнительных ссылках
    lazy var additionalLinksInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        let attributedText = NSAttributedString(
            string: "Вы можете создать дополнительные ссылки и задать для них срок действия, ограничение на число пользователей или плату за подписку.",
            attributes: [
                .kern: -0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: Colors.light1Gray
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(additionalLinksInfoLabel)
        
        NSLayoutConstraint.activate([
            // Настройка позиции и размеров для additionalLinksInfoLabel
            additionalLinksInfoLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            additionalLinksInfoLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 15),
            additionalLinksInfoLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -15)
        ])
    }
    
}
