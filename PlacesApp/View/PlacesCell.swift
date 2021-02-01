//
//  PlacesCell.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import UIKit

class PlacesCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDistanceLabel: UILabel!
    
    public static var reuseIdentifier = "PlacesCell"
    
    public func setData(place: Place, currentLocation: Location) {
        self.placeNameLabel.text = place.name
        let distance = Utils.getDistance(locationFrom: (place.geometry?.location)!, locationTo: currentLocation)
        self.placeDistanceLabel.text = "\(distance) m"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
}
