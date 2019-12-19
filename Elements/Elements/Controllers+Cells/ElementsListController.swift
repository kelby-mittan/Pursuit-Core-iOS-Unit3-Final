//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsListController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadElements()
    }
    
    
    private func loadElements() {
        ElementAPIClient.getElements { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let elements):
                DispatchQueue.main.async {
                    self?.elements = elements
                }
            }
        }
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            guard let elementVC = segue.destination as? ElementDetailController, let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("could not load")
            }
            
            elementVC.element = elements[indexPath.row]
            elementVC.isAllElements = true
            
        }
    
}

extension ElementsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError()
        }
        let element = elements[indexPath.row]
        cell.configureCell(for: element)
        
        return cell
    }
}

extension ElementsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

