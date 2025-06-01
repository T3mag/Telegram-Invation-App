import UIKit

class GroupInavtionView: UIView {

    /// Список дополнительных ссылок
    lazy var additionalLinksTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(AddInvationLinksTableViewCell.self,
                           forCellReuseIdentifier: "addLinks")
        tableView.register(lnvationLinksTableViewCell.self,
                           forCellReuseIdentifier: "invationLinks")
        
        tableView.register(GroupInvationTableSectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: "additionalHeader")
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        additionalLinksTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка экрана
    func setupLayout() {

        addSubview(additionalLinksTableView)
        
        NSLayoutConstraint.activate([
            // Настройка позиции и размеров для additionalLinksTableView
            additionalLinksTableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor),
            additionalLinksTableView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 17),
            additionalLinksTableView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -17),
            additionalLinksTableView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            
        ])
    }
    
}
