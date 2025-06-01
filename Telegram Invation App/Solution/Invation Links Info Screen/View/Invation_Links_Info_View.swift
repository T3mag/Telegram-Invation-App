import UIKit

class InvationLinksInfoView: UIView {
    
    lazy var invationLinksInfoTableView: UITableView = {
        let tableView = CustomTableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.backgroundColor = Colors.darkGray
        tableView.register(PeopleJoinedByLinksTableViewCell.self,
                           forCellReuseIdentifier: "joinedCell")
        tableView.register(CellHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "cellHeader")
        return tableView
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
        addSubview(invationLinksInfoTableView)
        
        NSLayoutConstraint.activate([
            invationLinksInfoTableView.topAnchor.constraint(equalTo: topAnchor),
            invationLinksInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            invationLinksInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            invationLinksInfoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
