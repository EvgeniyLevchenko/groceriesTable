//
//  ViewController.swift
//  pullToRefreshTableView
//
//  Created by QwertY on 01.11.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func editButton(_ sender: Any) {
        if (tableView.isEditing == true) {
            tableView.isEditing = false
            navigationItem.leftBarButtonItem?.title = "Edit"

        } else {
            tableView.isEditing = true
            navigationItem.leftBarButtonItem?.title = "Done"
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var groceries = ["Carrot", "Fish", "Milk"]
    private var pullControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        pullControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = pullControl
        } else {
            tableView.addSubview(pullControl)
        }
    }
    
    @objc private func refreshListData(_ sender: Any) {
        tableView.reloadData()
        self.pullControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceriesCell", for: indexPath)
        cell.textLabel?.text = groceries[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            groceries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        groceries.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addItemViewController = segue.destination as? AddItemViewController {
            addItemViewController.callback = { message in
                self.groceries.append(message)
                self.tableView.reloadData()
            }
        }
    }


}

