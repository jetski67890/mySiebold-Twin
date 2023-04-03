//
//  MenuCell.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class MenuCell: UITableViewCell {
    private let dateLabel = UILabel()
    private let breakfastLabel = UILabel()
    private let lunchLabel = UILabel()
    private let snackLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       configureUI()
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
   private func configureUI() {
        
       dateLabel.font = UIFont.preferredFont(forTextStyle: .headline)
       breakfastLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
       lunchLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
       snackLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
       
       breakfastLabel.numberOfLines = 0
       breakfastLabel.lineBreakMode = .byWordWrapping
       
       lunchLabel.numberOfLines = 0
       lunchLabel.lineBreakMode = .byWordWrapping

       contentView.addSubview(dateLabel)
       contentView.addSubview(breakfastLabel)
       contentView.addSubview(lunchLabel)
       contentView.addSubview(snackLabel)

       dateLabel.translatesAutoresizingMaskIntoConstraints = false
       breakfastLabel.translatesAutoresizingMaskIntoConstraints = false
       lunchLabel.translatesAutoresizingMaskIntoConstraints = false
       snackLabel.translatesAutoresizingMaskIntoConstraints = false

       // Set up constraints for the UI components
       NSLayoutConstraint.activate([
           dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
           dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
           
           breakfastLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
           breakfastLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
           breakfastLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),

           lunchLabel.topAnchor.constraint(equalTo: breakfastLabel.bottomAnchor, constant: 8),
           lunchLabel.leadingAnchor.constraint(equalTo: breakfastLabel.leadingAnchor),
           lunchLabel.trailingAnchor.constraint(equalTo: breakfastLabel.trailingAnchor),

           snackLabel.topAnchor.constraint(equalTo: lunchLabel.bottomAnchor, constant: 8),
           snackLabel.leadingAnchor.constraint(equalTo: lunchLabel.leadingAnchor),
           snackLabel.trailingAnchor.constraint(equalTo: lunchLabel.trailingAnchor),
           snackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with menu: Menu) {
        dateLabel.text = menu.date
        breakfastLabel.text = "Breakfast: \(menu.breakfast.main) with \(menu.breakfast.side), \(menu.breakfast.dessert), and \(menu.breakfast.beverage)"
        lunchLabel.text = "Lunch: \(menu.lunch.main) with \(menu.lunch.side), \(menu.lunch.dessert), and \(menu.lunch.beverage)"
        snackLabel.text = "Snack: \(menu.snack)"
    }
}
