//
//  DetailsViewController.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 25/07/22.
//

import UIKit
import RxSwift
import UIKit

class DetailsViewController: UIViewController {

    var user: User!
    var posts: [Post] = []
    let disposeBag = DisposeBag()
    let userPostsViewModel = DetailsUserPostsViewModel()

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var userPhoneLabel: UILabel!

    @IBOutlet var postsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        postsTableView.delegate = self
        title = "Prueba de Ingreso"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        configureTableView()
        setUI()
        bind()
    }

    func setUI() {
        userNameLabel.text = user?.name
        userEmailLabel.text = user?.email
        userPhoneLabel.text = user?.phone
    }
    
    private func configureTableView() {
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.register(UINib(nibName: "PostCellTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCellTableViewCell")
    }

    func bind() {
        if user != nil {
            userPostsViewModel.input.userId.accept("\(user.id ?? 0)")
            userPostsViewModel.output.posts.asObservable().subscribe(
                onNext: { posts in
                    self.cleanTable()
                    for post in posts ?? [] {
                        self.posts.append(post)
                        self.updateTable()
                    }

                }).disposed(by: disposeBag)
        }
    }

    func cleanTable() {
        postsTableView.endUpdates()
        posts.removeAll()
        postsTableView.reloadData()
    }

    func updateTable() {
        let indexPath = IndexPath(row: posts.count - 1, section: 0)

        postsTableView.beginUpdates()
        postsTableView.insertRows(at: [indexPath], with: .automatic)
        postsTableView.endUpdates()
    }
}


