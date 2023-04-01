//
//  MenuViewController.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()

    private var menus: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureTableView()
    }


    private func configureTableView() {
        title = "Menu"
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
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
        DataManager.shared.fetchMenus { [weak self] result in
            switch result {
            case .success(let substitutions):
                DispatchQueue.main.async {
                    self?.menus = substitutions
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching appointments: \(error)")
            }
        }
    }

    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.configure(with: menus[indexPath.row])
        return cell
    }

}
