
import UIKit

class GroupInvationTableSectionHeader: UITableViewHeaderFooterView {
    
    /// Надпись "Дополнительные ссылки"
    lazy var additionalLinksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.light1Gray
        label.isUserInteractionEnabled = false
        
        let attributedText = NSAttributedString(
            string: "ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ",
            attributes: [
                .kern: +0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: Colors.light1Gray
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .blue
        addSubview(additionalLinksLabel)
        
        NSLayoutConstraint.activate([
            additionalLinksLabel.topAnchor.constraint(
                equalTo: topAnchor, constant: -14),
            additionalLinksLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 17)
        ])
    }
}


