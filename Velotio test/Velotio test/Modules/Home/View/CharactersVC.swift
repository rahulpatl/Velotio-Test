//
//  ViewController.swift
//  Velotio test
//
//  Created by Rahul Patil on 17/11/22.
//

import UIKit

class CharactersVC: UIViewController {
    var output: CharactersViewOutput?

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        layout.itemSize = getMovieCellSize()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Marvel Character"
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CharacterCollectionCell.identifire, bundle: nil), forCellWithReuseIdentifier: CharacterCollectionCell.identifire)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.searchText), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel: CharactersViewModel?
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loader(startAnimating: true)
        output?.search(character: "Ant")
    }
    
    func getMovieCellSize() -> CGSize {
        let spacing = Constants.defaultSpacing
        let cellWidth: CGFloat = (UIScreen.main.bounds.width / 3) - (3 - spacing) - 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    private func setupViews() {
        title = "Marvel"
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension CharactersVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.charactersCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let character = viewModel?.characterAt(index: indexPath.item) else {
            return defaultCell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifire, for: indexPath) as? CharacterCollectionCell else {
            return defaultCell
        }
        cell.delegate = self
        cell.set(data: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension CharactersVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.updateSearch(text: searchText)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchText), object: nil)
        perform(#selector(self.searchText), with: nil, afterDelay: 1.5)
    }
    
    @objc private func searchText() {
        guard let text = viewModel?.srarchText else {
            output?.search(character: "")
            return
        }
        loader(startAnimating: true)
        output?.search(character: text)
    }
    
    func loader(startAnimating: Bool) {
        if startAnimating {
            self.view.addSubview(loaderView)
            loader.startAnimating()
        } else {
            loader.stopAnimating()
            refreshControl.endRefreshing()
            loaderView.removeFromSuperview()
        }
    }
}

extension CharactersVC: CharactersViewInput {
    func reloadData() {
        collectionView.reloadData()
        loader(startAnimating: false)
    }
}

extension CharactersVC: CharacterCellDelegate {
    func addBookmark(model: CharacterDetailsStorage) {
        view.endEditing(true)
        output?.makeBookmark(character: model)
    }
}
