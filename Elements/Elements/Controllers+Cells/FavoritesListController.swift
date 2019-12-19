//
//  FavoritesListController.swift
//  Elements
//
//  Created by Kelby Mittan on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesListController: UIViewController {
    
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
    
    
    @objc private func loadElements() {
        ElementAPIClient.getFavorites { [weak self] (result) in
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
        elementVC.isAllElements = false
        
    }
    
}

extension FavoritesListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError()
        }
        let element = elements[indexPath.row]
        cell.configureCell(for: element)
        
        return cell
    }
}

extension FavoritesListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


