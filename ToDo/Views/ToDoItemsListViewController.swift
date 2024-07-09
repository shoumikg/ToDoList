//
//  ToDoItemsListViewController.swift
//  ToDo
//
//  Created by Shoumik on 07/05/24.
//

import UIKit
import Combine

protocol ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem)
}

class ToDoItemsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var toDoItemStore: ToDoItemStoreProtocol? = ToDoItemStore()
    private var items: [ToDoItem] = []
    private var token: AnyCancellable?
    let dateFormatter = DateFormatter()
    private var dataSource: UITableViewDiffableDataSource<Section, ToDoItem>?
    var delegate: ToDoItemsListViewControllerProtocol?
    
    override func viewDidLoad() {
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        //tableView.dataSource = self
        tableView.delegate = self
        dataSource = UITableViewDiffableDataSource<Section, ToDoItem>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
            cell.titleLabel.text = itemIdentifier.title
            if let timestamp = itemIdentifier.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
            }
            return cell
        })
        
        token = toDoItemStore?.itemPublisher.sink(receiveValue: { [weak self] items in
            guard let self else { return }
            self.items = items
            self.update(with: items)
        })
    }
    
    enum Section {
        case todo
        case done
    }
    
    private func update(with items: [ToDoItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter({ $0.done == false }), toSection: .todo)
        snapshot.appendItems(items.filter({ $0.done == true }), toSection: .done)
        dataSource?.apply(snapshot)
    }
}

extension ToDoItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        self.delegate?.selectToDoItem(self, item: item)
    }
}

/*extension ToDoItemsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
        cell.titleLabel.text = items[indexPath.row].title
        if let timestamp = items[indexPath.row].timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            cell.dateLabel.text = dateFormatter.string(from: date)
        }
        return cell
    }
}*/
