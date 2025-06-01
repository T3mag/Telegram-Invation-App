import UIKit

class lnvationLinksTableViewCell: UITableViewCell {

    lazy var seporationLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.selectedGray
        return view
    }()
    
    lazy var linkCircleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.linkCircleFill
        imageView.tintColor = Colors.lightBlue
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    lazy var linkNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Хайдар"
        return label
    }()
    
    lazy var linkCountsJoinedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSeporationLine() {
        
        addSubview(seporationLineView)
        
        NSLayoutConstraint.activate([
            seporationLineView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            seporationLineView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            seporationLineView.leadingAnchor.constraint(
                equalTo: linkNameLabel.leadingAnchor),
            seporationLineView.heightAnchor.constraint(
                equalToConstant: 1)
        ])
    }
    
    func configure(link: Link?) {
        linkNameLabel.text = link?.linkTitile
        let attributedText = NSAttributedString(
            string: link?.countJoined ?? "",
            attributes: [
                .kern: -0.2, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: Colors.light1Gray
            ]
        )
        linkCountsJoinedLabel.attributedText = attributedText
    }
    
    func makeCornersRound(with eagles: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = eagles
        
        clipsToBounds = true
    }
    
    func setupLayout() {
        backgroundColor = Colors.darkGray
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.selectedGray
        selectedBackgroundView = bgColorView
        
        addSubview(linkCircleImageView)
        addSubview(linkNameLabel)
        addSubview(linkCountsJoinedLabel)
        
        NSLayoutConstraint.activate([
            linkCircleImageView.topAnchor.constraint(equalTo:
                topAnchor, constant: 8),
            linkCircleImageView.bottomAnchor.constraint(equalTo:
                bottomAnchor, constant: -8),
            linkCircleImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 13),
            linkCircleImageView.widthAnchor.constraint(
                equalToConstant: 45),
            linkCircleImageView.heightAnchor.constraint(
                equalToConstant: 45),
            
            linkNameLabel.centerYAnchor.constraint(
                equalTo: linkCircleImageView.centerYAnchor, constant: -10),
            linkNameLabel.leadingAnchor.constraint(
                equalTo: linkCircleImageView.trailingAnchor, constant: 13),
            
            linkCountsJoinedLabel.centerYAnchor.constraint(
                equalTo: linkCircleImageView.centerYAnchor, constant: 12),
            linkCountsJoinedLabel.leadingAnchor.constraint(
                equalTo: linkCircleImageView.trailingAnchor, constant: 13),
        ])
    }

}
