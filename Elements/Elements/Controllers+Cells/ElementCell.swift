//
//  ElementCell.swift
//  Elements
//
//  Created by Kelby Mittan on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet var elementImage: UIImageView!
    
    @IBOutlet var elementName: UILabel!
    
    @IBOutlet var symbolWeightLabel: UILabel!
    
    private var urlString = ""
    
    func configureCell(for element: Element) {
        
        elementName.text = element.name
        symbolWeightLabel.text = "\(element.symbol)(\(element.number.description)) \(element.atomicMass.description)"
        
        var elementNumString = element.number.description
        
        if elementNumString.count == 1 {
            elementNumString = "00\(elementNumString)"
        } else if elementNumString.count == 2 {
            elementNumString = "0\(elementNumString)"
        }
        
        urlString = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumString)/s7.JPG"
        
        elementImage.getImage(with: urlString) { [weak self] (result) in
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        elementImage.image = UIImage(systemName: "circle.grid.hex")
    }
    
}

