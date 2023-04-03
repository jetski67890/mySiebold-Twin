//
//  SubstitutionCell.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class SubstitutionCell: UITableViewCell {
    private let subjectLabel = UILabel()
    private let dateLabel = UILabel()
    private let periodLabel = UILabel()
    private let teacherLabel = UILabel()
    private let roomLabel = UILabel()
    private let infoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        
        subjectLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        periodLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        teacherLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        roomLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        infoLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

        contentView.addSubview(subjectLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(periodLabel)
        contentView.addSubview(teacherLabel)
        contentView.addSubview(roomLabel)
        contentView.addSubview(infoLabel)

        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        teacherLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints for the UI components
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            subjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subjectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: subjectLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: subjectLabel.trailingAnchor),

            periodLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            periodLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            periodLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),

            teacherLabel.topAnchor.constraint(equalTo: periodLabel.bottomAnchor, constant: 4),
            teacherLabel.leadingAnchor.constraint(equalTo: periodLabel.leadingAnchor),
            teacherLabel.trailingAnchor.constraint(equalTo: periodLabel.trailingAnchor),

            roomLabel.topAnchor.constraint(equalTo: teacherLabel.bottomAnchor, constant: 4),
            roomLabel.leadingAnchor.constraint(equalTo: teacherLabel.leadingAnchor),
            roomLabel.trailingAnchor.constraint(equalTo: teacherLabel.trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: roomLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: roomLabel.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with substitution: Substitution) {
        subjectLabel.text = substitution.subject
        dateLabel.text = "Date: \(substitution.date)"
        periodLabel.text = "Period: \(substitution.startTime) - \(substitution.endTime)"
        teacherLabel.text = "Teacher: \(substitution.teacher)"
        roomLabel.text = "Room: \(substitution.room.number) - \(substitution.room.name)"
        infoLabel.text = "Info: \(substitution.info)"
    }
}
