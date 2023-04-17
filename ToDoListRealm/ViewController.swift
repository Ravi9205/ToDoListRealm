//
//  ViewController.swift
//  ToDoListRealm
//
//  Created by Ravi Dwivedi on 15/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var contactData = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func addBarButtonPressed(_ sender: Any) {
        showAlert(isAdded: true, index: 0)
    }
}


extension ViewController{
    
    func showAlert(isAdded:Bool, index:Int){
        let alertVC:UIAlertController
        if isAdded {
            alertVC = UIAlertController(title:"Add Contact", message:"Please enter your contact details", preferredStyle: .alert)
            
            alertVC.addTextField { firstNameField in
                firstNameField.placeholder = "Enter your first name"
            }
            
            alertVC.addTextField { lastNameField in
                lastNameField.placeholder = "Enter your last name"
            }
            
            let save = UIAlertAction(title:"Save", style: .default) {[weak self] _ in
                
                if let firstName = alertVC.textFields?.first?.text, let lastName = alertVC.textFields?[1].text {
                    //print("\(firstName)  \(lastName)")
                    let contact = Contact(_firstName:firstName, _lastName: lastName)
                    self?.contactData.append(contact)
                    self?.tableView.reloadData()
                    
                }
            }
            alertVC.addAction(save)
            
        }
        else{
            alertVC = UIAlertController(title:"Update Contact", message:"Please enter your contact details to update", preferredStyle: .alert)
            
            alertVC.addTextField { firstNameField in
                firstNameField.placeholder = self.contactData[index].firstName
            }
            
            alertVC.addTextField { lastNameField in
                lastNameField.placeholder = self.contactData[index].lastName
            }
            
            let update = UIAlertAction(title:"Update", style: .default) {[weak self] _ in
                
                if let firstName = alertVC.textFields?.first?.text, let lastName = alertVC.textFields?[1].text {
                    let contact = Contact(_firstName:firstName, _lastName: lastName)
                    self?.contactData[index] = contact
                    self?.tableView.reloadData()
                    
                }
            }
            alertVC.addAction(update)
        }
        
        let cancel = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true)
    }
}

//MARK:- TableView Data Source
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = self.tableView.dequeueReusableCell(withIdentifier:"cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier:"cell")
        cell.textLabel?.text = contactData[indexPath.row].firstName
        cell.detailTextLabel?.text = contactData[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

//MARK:- TableView Delegate
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title:"Edit") {[weak self] _, _, _ in
            self?.showAlert(isAdded: false, index: indexPath.row)
        }
        
        let delete = UIContextualAction(style: .destructive, title:"Delete") {[weak self] _, _, _ in
            self?.contactData.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        
        let swipeCongigurations = UISwipeActionsConfiguration(actions: [delete,edit])
        return swipeCongigurations
    }
    
}
