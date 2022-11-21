//
//  DetailsVC.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import UIKit
class DetailsVC: UIViewController {
    var output: DetailsViewOutput?
    var comics = [Items]()
    var character: CharacterDetails?
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib(nibName: ImageCell.id, bundle: nil), forCellReuseIdentifier: ImageCell.id)
        tableView.register(UINib(nibName: ComicsCell.id, bundle: nil), forCellReuseIdentifier: ComicsCell.id)
        return tableView
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        return loader
    }()
    
    lazy var loaderView: UIView = {
        let loaderView = UIView(frame: UIScreen.main.bounds)
        loaderView.addSubview(loader)
        loaderView.backgroundColor = .lightGray.withAlphaComponent(0.8)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return loaderView
    }()
    
    override func loadView() {
        let _view = UIView()
        _view.backgroundColor = .white
        self.view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loader(startAnimating: true)
        output?.fetchData()
    }
    
    func setUpUI() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
    
    func loader(startAnimating: Bool) {
        if startAnimating {
            self.view.addSubview(loaderView)
            loader.startAnimating()
        } else {
            loader.stopAnimating()
            loaderView.removeFromSuperview()
        }
    }
}

extension DetailsVC: DetailsViewInput {
    func update(comics: [Items], details: CharacterDetails) {
        self.comics = comics
        self.character = details
        self.title = details.name
        tableView.reloadData()
        loader(startAnimating: false)
    }
}

extension DetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.id, for: indexPath) as? ImageCell,
            let character = character else {
                return UITableViewCell()
            }
            cell.set(data: character)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.id, for: indexPath) as? ComicsCell else {
                return UITableViewCell()
            }
            cell.set(data: comics[indexPath.row - 1].name ?? "")
            return cell
        }
    }
}
