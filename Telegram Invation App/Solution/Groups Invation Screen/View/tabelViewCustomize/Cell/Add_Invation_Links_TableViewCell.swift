import UIKit

class AddInvationLinksTableViewCell: UITableViewCell {
    
    lazy var seporationLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.selectedGray
        return view
    }()
    
    /// картинка с "плюсиком"
    lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.plusImage
        imageView.tintColor = Colors.lightBlue
        return imageView
    }()
    
    /// Надпись "Создасть ссылку"
    lazy var createLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSAttributedString(
            string: "Создать ссылку",
            attributes: [
                .kern: -0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 19),
                .foregroundColor: Colors.lightBlue
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCornersRound(with eagles: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = eagles
        
        clipsToBounds = true
    }
    
    func setupSeporationLine() {
        backgroundColor = Colors.darkGray
        
        addSubview(seporationLineView)
        
        NSLayoutConstraint.activate([
            seporationLineView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            seporationLineView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            seporationLineView.leadingAnchor.constraint(
                equalTo: createLinkLabel.leadingAnchor),
            seporationLineView.heightAnchor.constraint(
                equalToConstant: 1)
        ])
    }
    
    func setupLayout() {
        backgroundColor = Colors.darkGray
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.selectedGray
        selectedBackgroundView = bgColorView
        
        addSubview(addImageView)
        addSubview(createLinkLabel)
        
        NSLayoutConstraint.activate([
            addImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 13),
            addImageView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -13),
            addImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 27),
            
            createLinkLabel.centerYAnchor.constraint(
                equalTo: addImageView.centerYAnchor),
            createLinkLabel.leadingAnchor.constraint(
                equalTo: addImageView.trailingAnchor, constant: 20)
        ])
    }
    
}
