//
//  AlbumController.swift
//  ShoppingApp
//
//  Created by Telem Tobi on 13/04/2020.
//  Copyright © 2020 Telem Tobi. All rights reserved.
//

import UIKit

class AlbumController: UIViewController {
    
    var topView: AlbumTopView!
    var detailsView: AlbumDetailsView!
    var trackCollectionView: TracksCollectionView!
    
    var delegate: AlbumDelegate?
    var backButton: UIButton!
    var cartButton: UIButton!
    
    var topViewHeightAnchor: NSLayoutConstraint!
    
    var album: Album? {
        didSet {
            topView.album = album
            detailsView.album = album
            trackCollectionView.tracks = album?.tracks
        }
    }
    
    var isCollapsed: Bool = false {
        willSet {
            topViewHeightAnchor.constant = newValue ? view.frame.height * 0.15 : view.frame.height * 0.4
            UIView.animate(withDuration: 0.5, animations: {
                self.topView.shouldCollapse(newValue)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        setTopView()
        setDetailsView()
        setBackButton()
        setCartButton()
        setTracksCollectionView()
        setGestures()
    }
    
    private func setUpElements() {
        view.backgroundColor = .myBackgroundColor
    }
    
    private func setGestures() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc private func handleSwipeUp(_ swipe: UISwipeGestureRecognizer) {
        if !isCollapsed {
            isCollapsed = true
        }
    }
    
    @objc private func handleSwipeDown(_ swipe: UISwipeGestureRecognizer) {
        if isCollapsed {
            isCollapsed = false
        }
    }
    
    private func setTopView() {
        topView = AlbumTopView()
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topViewHeightAnchor = topView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4)
        topViewHeightAnchor.isActive = true
    }
    
    private func setDetailsView() {
        detailsView = AlbumDetailsView()
        view.addSubview(detailsView)
        
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setTracksCollectionView() {
        let layout = LayoutsManager.shared.tracksLayout()
        trackCollectionView = TracksCollectionView(collectionViewLayout: layout)
        view.addSubview(trackCollectionView.view)
        
        trackCollectionView.view.translatesAutoresizingMaskIntoConstraints = false
        trackCollectionView.view.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 72).isActive = true
        trackCollectionView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        trackCollectionView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        trackCollectionView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setBackButton() {
        backButton = UIButton(type: .custom)
        backButton.backgroundColor = .none
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    private func setCartButton() {
        cartButton = UIButton(type: .custom)
        cartButton.backgroundColor = .secondaryColor
        cartButton.setImage(UIImage(named: "shopping-cart"), for: .normal)
        cartButton.imageView?.contentMode = .scaleAspectFit
        cartButton.layer.cornerRadius = 27.5
        cartButton.layer.borderWidth = 1
        cartButton.layer.borderColor = UIColor.myBackgroundColor.cgColor
//        cartButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(cartButton)
        
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cartButton.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        cartButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        cartButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
}
