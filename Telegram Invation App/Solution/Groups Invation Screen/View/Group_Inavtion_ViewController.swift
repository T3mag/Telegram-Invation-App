import UIKit
import CoreData
import AVFoundation
import AVKit

class GroupInavtionViewController: UIViewController, GroupInvationViewModelOutput {
    
    private var player : AVPlayer!
    private var avPlayerLayer : AVPlayerLayer!
    
    var viewModel: GroupInvationViewModelInput?
    private let contentView: GroupInavtionView = .init()
    
    private var tableViewHeader: GroupInvationTableHeadView?
    private var tableViewFooter: GroupInvationTableFooter?
    
    var fetchedResultController: NSFetchedResultsController<Link>?

    init() {
        super.init(nibName: nil, bundle: nil)
        tableViewHeader = GroupInvationTableHeadView(
            frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 555))
        tableViewFooter = GroupInvationTableFooter(
            frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        tableViewHeader?.delegate = self
        
        tableViewHeader?.setupCountOfPeopleAndPhoto(peoplePhotoPath: [], countPeoples: "0")
        
        contentView.additionalLinksTableView.tableHeaderView = tableViewHeader
        contentView.additionalLinksTableView.tableFooterView = tableViewFooter
        view = contentView
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Colors.darkGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Пригласительные ссылки"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        fetchedResultController = viewModel?.getPreparedFetchedResultController()
        fetchedResultController?.delegate = self
        updateTableWithCachedData()
        
        contentView.additionalLinksTableView.delegate = self
        contentView.additionalLinksTableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func updateTableWithCachedData() {
        do {
            try fetchedResultController?.performFetch()
            contentView.additionalLinksTableView.reloadData()
        } catch {
            print("Запрос к Fetch провален. Ошибка: \(error)")
        }
    }
}

extension GroupInavtionViewController: GroupInavtionViewDelegate, SetupInfoViewControllerDelete {
    func updateLinkAndPhotoJoined(link: String, peopleCount: String, peoplesName: [String]) {
        tableViewHeader?.invationLinkLabel.text = link
        var pathList: [AvatarInfo] = []
        
        for nickname in peoplesName {
            print(nickname)
            viewModel?.getUserPhotoByNickName(nickName: nickname) { result in
                switch result {
                case .success(let path):
                    pathList.append(path)
                    DispatchQueue.main.async {
                        let newHeader = GroupInvationTableHeadView(
                            frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 555))
                        
                        newHeader.delegate = self
                        newHeader.setupCountOfPeopleAndPhoto(peoplePhotoPath: pathList, countPeoples: peopleCount)
                        newHeader.invationLinkLabel.text = link
                        self.contentView.additionalLinksTableView.tableHeaderView = newHeader
                        self.contentView.additionalLinksTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func openSetingsView(type: TypeSetupInfoScreen) {
        let newViewController = SetupInfoAssembly.screenBuilderForLink(typeSetup: type, delegate: self)
        
        if let presentationController = newViewController.presentationController
            as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(newViewController, animated: true)
    }
}

extension GroupInavtionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let myIndexPath = IndexPath(row: indexPath!.row, section: 1)
        switch type {
        case .update:
            if let cell = contentView.additionalLinksTableView.cellForRow(at: myIndexPath) as? lnvationLinksTableViewCell {
                let object: Link = controller.object(at: indexPath!) as! Link
                cell.configure(link: object)
            }
            contentView.additionalLinksTableView.reloadData()
        case .insert:
            contentView.additionalLinksTableView.insertRows(at: [myIndexPath], with: .automatic)
            contentView.additionalLinksTableView.reloadData()
        case .delete:
            contentView.additionalLinksTableView.deleteRows(at: [myIndexPath], with: .automatic)
            contentView.additionalLinksTableView.reloadData()
        case .move:
            contentView.additionalLinksTableView.reloadData()

        @unknown default:
            print("Произошла неизвестная ошибка")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        contentView.additionalLinksTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        contentView.additionalLinksTableView.beginUpdates()
    }
    
}

extension GroupInavtionViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Устанавливаем кол-во секции
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // - не менять
    }
    
    /// Устанавливаем кол-во ллементов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return fetchedResultController?.sections?.first?.numberOfObjects ?? 0
        }
    }
    
    /// Устанавливаем высоту header секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return .leastNormalMagnitude
        }
    }
    
    /// Устанавливаем высоту footer секции
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return .leastNormalMagnitude
        } else {
            return 30
        }
    }
    
    /// Устанавливаем view для header секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "additionalHeader") as? GroupInvationTableSectionHeader else {
            fatalError()
        }
        
        if section == 0 {
            return header
        } else {
            return nil
        }
    }
    
    /// Настраиваем и отображем ячейки (cell)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        let totalEllemts = indexPath.count
        
        if indexPath.section == 0 {
            guard let addCell = tableView.dequeueReusableCell(
                withIdentifier: "addLinks", for: indexPath) as? AddInvationLinksTableViewCell else { fatalError() }
            if totalEllemts == 1 {
                addCell.makeCornersRound(with: [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner,
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner
                ], radius: 10)
                return addCell
            } else {
                addCell.setupSeporationLine()
                addCell.makeCornersRound(with: [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner
                ], radius: 10)
                
                return addCell
            }
        } else {
            guard let linksCell = tableView.dequeueReusableCell(
                withIdentifier: "invationLinks", for: indexPath) as? lnvationLinksTableViewCell else { fatalError() }
            
            let myIndexPath = IndexPath(row: indexPath.row, section: 0)
            let link = fetchedResultController?.object(at: myIndexPath)
            linksCell.configure(link: link)
            
            if indexPath.row == totalRows-1 {
                linksCell.makeCornersRound(with: [
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner
                ], radius: 10)
                
                return linksCell
            } else {
                linksCell.setupSeporationLine()
                linksCell.makeCornersRound(with: [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner,
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner
                ], radius: 0)
                
                return linksCell
            }
        }
    }
    
    /// Обрабатывем зажатие ячейки
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { suggestedActions in
            let to = IndexPath(row: indexPath.row, section: 0)
            if indexPath.section != 0{
                /// Возможность редактировать
                let edit = UIAction(title: "Редактировать",
                                    image: UIImage(systemName: "pencil")) { action in
                    
                    guard let selectedLink = self.fetchedResultController?.object(at: to) else {
                        print("объект не был найден")
                        return
                    }
                    
                    let newViewController = SetupInfoAssembly.screenBuilderForLink(link: selectedLink)
                    
                    if let presentationController = newViewController.presentationController
                        as? UISheetPresentationController {
                        presentationController.detents = [.medium()]
                    }
                    
                    self.present(newViewController, animated: true)
                }
                
                // Возможность удалять
                let delete = UIAction(title: "Удалить",
                                      image: UIImage(systemName: "trash"),
                                      attributes: .destructive) { action in
                    guard let selectedLink = self.fetchedResultController?.object(at: to) else {
                        print("объект не был найден")
                        return
                    }
                    self.viewModel?.deleteLink(link: selectedLink)
                }
                
                // Собираем UIMenu
                return UIMenu(title: "", children: [edit, delete])
            }
            
            return UIMenu()
        }
    }
    
    /// Обрабатываем нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let to = IndexPath(row: indexPath.row, section: 0)
        
        if indexPath.section != 0 {
            guard let selectedLink = self.fetchedResultController?.object(at: to) else {
                print("объект не был найден")
                return
            }
            
            let newViewController = InvationLinksInfoAssembly.screenBuilder(link: selectedLink)
            
            if let presentationController = newViewController.presentationController
                as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()]
                
                presentationController.prefersGrabberVisible = false
                presentationController.preferredCornerRadius = 20 // Задайте желаемый радиус
            }
            
            newViewController.modalPresentationStyle = .fullScreen
            
            self.present(newViewController, animated: true)
        } else {
            Task {
                await self.viewModel?.createNewInvationLink()
                self.updateTableWithCachedData()
            }
        }
    }
}

