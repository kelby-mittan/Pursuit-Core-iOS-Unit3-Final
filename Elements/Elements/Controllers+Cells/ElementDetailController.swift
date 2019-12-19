//
//  ElementDetailController.swift
//  Elements
//
//  Created by Kelby Mittan on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailController: UIViewController {

    @IBOutlet var symbolLabel: UILabel!
    
    @IBOutlet var elementImage: UIImageView!
    
    @IBOutlet var numWeightLabel: UILabel!
    
    @IBOutlet var meltingBoilingLabel: UILabel!
    
    @IBOutlet var discoveredByLabel: UILabel!
    
    var element: Element?
    var isAllElements = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        guard let element = element else {
            showAlert(title: "Error", message: "Could not get element")
            return
        }
        
        let imageUrl = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        if isAllElements {
            navigationItem.title = element.name
            symbolLabel.text = element.symbol
            numWeightLabel.text = "Num: \(element.number.description), Atomic Mass: \(element.atomicMass.description )"
            
            meltingBoilingLabel.text = "Melting pt: \(element.melt?.description ?? "N/A"), Boiling pt: \(element.boil?.description ?? "N/A")"
            
            discoveredByLabel.text = "Discovered by - \(element.discoveredBy ?? "N/A")"
        }
        
        elementImage.getImage(with: imageUrl) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "circle.grid.hex")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
        
    }

    @IBAction func postElementButton(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        guard let element = element else {
            fatalError("could not get element")
        }
        
        let postedElement = Element(name: element.name, appearance: element.appearance, atomicMass: element.atomicMass, boil: element.boil, category: element.category, discoveredBy: element.discoveredBy, melt: element.melt, summary: element.summary, number: element.number, period: element.period, symbol: element.symbol, favoritedBy: "Walter White", molarHeat: element.molarHeat, phase: element.phase, source: element.source)
        
        ElementAPIClient.postElement(for: postedElement) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post", message: "\(appError)")
                    sender.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite Posted", message: "Thanks for favoriting this element!!") { alert in
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
    }
    

}
