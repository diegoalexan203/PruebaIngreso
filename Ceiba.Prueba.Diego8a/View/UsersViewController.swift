//
//  UsersViewController.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 23/07/22.
//
import RxSwift
import UIKit

class UsersViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let usersViewModel = UsersViewModel()
    var users: [User] = []
    var filteredUsers = [User]()
    var searching = false
    var alert = UIAlertController()
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prueba de Ingreso"
        navigationController?.navigationBar.backgroundColor = Helpers().hexStringToUIColor(hex: "3A6036")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        usersTableView.delegate = self
        usersTableView.dataSource = self
        configureTableView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersViewModel.input.viewShow.accept(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searching = false
        usersViewModel.input.viewShow.accept(false)
        userSearchBar.searchTextField.text = ""
        userSearchBar.endEditing(true)
    }
    
    private func configureTableView() {
        usersTableView.rowHeight = UITableView.automaticDimension
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }

    func showAlert(message: String) {
        alert = UIAlertController(title: message,
                                  message: nil,
                                  preferredStyle: .alert)
        present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            self.alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }

    func dismissAlert() {
        alert.dismiss(animated: true, completion: nil)
    }

    @objc func dismissAlertController() {
        userSearchBar.searchTextField.text = ""
        searching = false
        usersTableView.reloadData()
        dismiss(animated: true, completion: nil)
        userSearchBar.endEditing(true)
    }

    func bind() {
        usersViewModel.output.users.asObservable().subscribe(
            onNext: { users in
                self.cleanTable()
                for user in users ?? [] {
                    self.users.append(user)
                    self.updateTable()
                }
                self.usersTableView.reloadData()
            }).disposed(by: disposeBag)
        usersViewModel.output.loading.asObservable().subscribe(
            onNext: { loading in
                if loading ?? false {
                    self.showAlert(message: "Obteniendo informacion...")
                } else {
                    self.dismissAlert()
                }

            }).disposed(by: disposeBag)
    }

    func cleanTable() {
        usersTableView.endUpdates()
        users.removeAll()
        usersTableView.reloadData()
    }

    func updateTable() {
        let indexPath = IndexPath(row: users.count - 1, section: 0)

        usersTableView.beginUpdates()
        usersTableView.insertRows(at: [indexPath], with: .automatic)
        usersTableView.endUpdates()
    }
}

