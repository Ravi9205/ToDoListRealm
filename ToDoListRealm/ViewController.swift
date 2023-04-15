//
//  ViewController.swift
//  ToDoListRealm
//
//  Created by Ravi Dwivedi on 15/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var data = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func addBarButtonPressed(_ sender: Any) {
        showAlert()
        
    }
}


extension ViewController{
    
    func showAlert(){
        let alertVC = UIAlertController(title:"Add Contact", message:"Please enter your contact details", preferredStyle: .alert)
       
        alertVC.addTextField { firstNameField in
            firstNameField.placeholder = "Enter your first name"
        }
        
        alertVC.addTextField { lastNameField in
            lastNameField.placeholder = "Enter your last name"
        }
        
        let save = UIAlertAction(title:"Save", style: .default) { _ in
            
            if let firstName = alertVC.textFields?.first?.text, let lastName = alertVC.textFields?[1].text {
                
                print("\(firstName)  \(lastName)")
            }
        }
        let cancel = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
        
        
        alertVC.addAction(cancel)
        alertVC.addAction(save)
        self.present(alertVC, animated: true)
        
    }
}

//MARK:- TableView Data Source

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        return cell
    }
    
}

//MARK:- TableView Delegate
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
