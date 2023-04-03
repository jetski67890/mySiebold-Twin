//
//  AppointmentCell.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class AppointmentCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let locationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        timeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        locationLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(locationLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints for the UI components
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),

            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with appointment: Appointment) {
        titleLabel.text = appointment.title
        dateLabel.text = "Date: \(appointment.date)"
        timeLabel.text = "Time: \(appointment.startTime) - \(appointment.endTime)"
        locationLabel.text = "Room: \(appointment.location)"
    }
}
