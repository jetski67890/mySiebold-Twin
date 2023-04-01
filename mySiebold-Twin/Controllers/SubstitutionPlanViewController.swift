//
//  SubstitutionPlanViewController.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class SubstitutionPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let classesDropDown = UIPickerView()
    private let classesTextField = UITextField()

    private var substitutions: [Substitution] = []
    private var filteredSubstitutions: [Substitution] = []
    private var classes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureDropDown()
        configureTableView()
    }

    private func configureDropDown() {
        classesTextField.inputView = classesDropDown
        classesTextField.placeholder = "Select class"
        classesTextField.borderStyle = .roundedRect
        classesTextField.textAlignment = .center
        view.addSubview(classesTextField)
        classesTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            classesTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            classesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            classesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            classesTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        classesDropDown.dataSource = self
        classesDropDown.delegate = self
    }

    private func configureTableView() {
        title = "Substitution Plans"
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubstitutionCell.self, forCellReuseIdentifier: "SubstitutionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: classesTextField.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func fetchData() {
        DataManager.shared.fetchSubstitutions { [weak self] result in
            switch result {
            case .success(let substitutions):
                DispatchQueue.main.async {
                    self?.substitutions = substitutions
                    self?.classes = Array(Set(substitutions.map { $0.class })).sorted()
                    self?.tableView.reloadData()
                    self?.classesDropDown.reloadAllComponents()
                }
            case .failure(let error):
                print("Error fetching appointments: \(error)")
            }
        }
    }

    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSubstitutions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubstitutionCell", for: indexPath) as! SubstitutionCell
        cell.configure(with: filteredSubstitutions[indexPath.row])
        return cell
    }

}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate
extension SubstitutionPlanViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedClass = classes[row]
        classesTextField.text = selectedClass
        classesTextField.resignFirstResponder()
        filterSubstitutions(for: selectedClass)
    }

    private func filterSubstitutions(for selectedClass: String) {
        filteredSubstitutions = substitutions.filter { $0.class == selectedClass }
        tableView.reloadData()
    }
}

