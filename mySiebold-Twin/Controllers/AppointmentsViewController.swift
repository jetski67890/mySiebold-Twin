//
//  AppointmentsViewController.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class AppointmentsViewController: UIViewController {
    private let tableView = UITableView()
    private var appointments: [Appointment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }

    private func configureUI() {
        view.backgroundColor = .black
        title = "Appointments"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "AppointmentCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func fetchData() {
        DataManager.shared.fetchAppointments { [weak self] result in
            switch result {
            case .success(let appointments):
                DispatchQueue.main.async {
                    self?.appointments = appointments
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching appointments: \(error)")
            }
        }
    }
}

extension AppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        cell.configure(with: appointments[indexPath.row])
        return cell
    }
}
