//
//  AnimalsViewController.swift
//  HGRippleRadarView_Example
//
//  Created by Hamza Ghazouani on 05/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import HGRippleRadarView

class AnimalsViewController: UIViewController {

    @IBOutlet weak var radarView: RadarView!
    @IBOutlet weak var selectedAnimalView: AnimalView!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    /// 声音，光环
    private lazy var speakRippleView: HGRippleRadarView.RippleView = {
        let rippleView = HGRippleRadarView.RippleView(frame: .zero)
        rippleView.centerAnimatedStyle = .alternate
        rippleView.diskRadius = (55 + 6) / 2.0
        rippleView.diskColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 0.5)
        rippleView.diskStrokeColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 1)
        rippleView.centerAnimatedColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 0.5)
        rippleView.centerAnimatedStrokeColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 1)
        rippleView.centerAnimatedStrokeWidth = 0.5
        rippleView.numberOfCircles = 0
        rippleView.animationDuration = 1.8
        rippleView.isUserInteractionEnabled = false
        rippleView.startAnimation()
        return rippleView
    }()
    
    /// 声音，光环
    private lazy var speakRippleView2: HGRippleRadarView.RippleView = {
        let rippleView = HGRippleRadarView.RippleView(frame: .zero)
        rippleView.centerAnimatedStyle = .zoom
        rippleView.diskRadius = (55 + 6) / 2.0
        rippleView.diskColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 0.5)
        rippleView.diskStrokeColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 1)
        rippleView.centerAnimatedColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 0.5)
        rippleView.centerAnimatedStrokeColor = UIColor(red: 0 / 255.0, green: 255/255.0, blue: 138/255.0, alpha: 1)
        rippleView.centerAnimatedStrokeWidth = 0.5
        rippleView.numberOfCircles = 0
        rippleView.animationDuration = 1
        rippleView.isUserInteractionEnabled = false
        rippleView.startAnimation()
        return rippleView
    }()
    
    
    func createAlternateRadar() {
        let radarWidth: CGFloat = 30
        let avatarView = UIImageView()
        avatarView.image = UIImage(named: "tiger")
        avatarView.backgroundColor = .white
        avatarView.layer.cornerRadius = 55 / 2.0
        avatarView.layer.masksToBounds = true
        view.addSubview(avatarView)
        avatarView.frame = CGRect(x: 150, y: 150, width: 55, height: 55)
        
        view.insertSubview(speakRippleView, belowSubview: avatarView)
        speakRippleView.frame = CGRect(x: avatarView.frame.minX - radarWidth, y: avatarView.frame.minY - radarWidth, width: avatarView.frame.width + radarWidth * 2, height: avatarView.frame.height + radarWidth * 2)
    }
    
    func createZoomRadar() {
        
        let radarWidth: CGFloat = 30
        let avatarView = UIImageView()
        avatarView.image = UIImage(named: "tiger")
        avatarView.backgroundColor = .white
        avatarView.layer.cornerRadius = 55 / 2.0
        avatarView.layer.masksToBounds = true
        view.addSubview(avatarView)
        avatarView.frame = CGRect(x: 150, y: 150 + 150 + 10, width: 55, height: 55)
        
        view.insertSubview(speakRippleView2, belowSubview: avatarView)
        speakRippleView2.frame = CGRect(x: avatarView.frame.minX - radarWidth, y: avatarView.frame.minY - radarWidth, width: avatarView.frame.width + radarWidth * 2, height: avatarView.frame.height + radarWidth * 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        createAlternateRadar()
        createZoomRadar()
        
        radarView.isHidden = true
        radarView?.dataSource = self
        radarView?.delegate = self
        
       let animals = [
            Animal(title: "Bird", color: .lightBlue, imageName: "bird"),
            Animal(title: "Cat", color: .lightGray, imageName: "cat"),
            Animal(title: "Cattle", color: .lightGray, imageName: "catttle"),
            Animal(title: "Dog", color: .darkYellow, imageName: "dog"),
            Animal(title: "Rat", color: .lightBlack, imageName: "rat")
        ]
       let items = animals.map { Item(uniqueKey: $0.title, value: $0) }
        radarView.add(items: items)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func enlarge(view: UIView?) {
        let animation = Animation.transform(from: 1.0, to: 1.5)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        view?.layer.add(animation, forKey: "transform")
    }
    
    private func reduce(view: UIView?) {
        let animation = Animation.transform(from: 1.5, to: 1.0)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        view?.layer.add(animation, forKey: "transform")
    }
    
    private func showView(for animal: Animal) {
        selectedAnimalView.tintColor = animal.color
        selectedAnimalView.titleLabel.text = animal.title
        if let image =  UIImage(named: animal.imageName) {
            selectedAnimalView.imageView.image = image
        }

        bottomLayoutConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideAnimalView(completion: (() -> Void)? = nil) {
        bottomLayoutConstraint.constant = -250
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            completion?()
        }
    }
}

extension AnimalsViewController: RadarViewDataSource {
    
    func radarView(radarView: RadarView, viewFor item: Item, preferredSize: CGSize) -> UIView {
        let animal = item.value as? Animal
        let frame = CGRect(x: 0, y: 0, width: preferredSize.width, height: preferredSize.height)
        let imageView = UIImageView(frame: frame)
        
        guard let imageName = animal?.imageName else { return imageView }
        let image =  UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill

        return imageView
    }
}

extension AnimalsViewController: RadarViewDelegate {
    
    func radarView(radarView: RadarView, didSelect item: Item) {
        let view = radarView.view(for: item)
        enlarge(view: view)
        
        guard let animal = item.value as? Animal else { return }
        if bottomLayoutConstraint.constant == 0 {
            hideAnimalView {
                self.showView(for: animal)
            }
        } else {
            showView(for: animal)
        }
    }
    
    func radarView(radarView: RadarView, didDeselect item: Item) {
        let view = radarView.view(for: item)
        reduce(view: view)
    }
    
    func radarView(radarView: RadarView, didDeselectAllItems lastSelectedItem: Item) {
        let view = radarView.view(for: lastSelectedItem)
        reduce(view: view)
        hideAnimalView()
    }
}
