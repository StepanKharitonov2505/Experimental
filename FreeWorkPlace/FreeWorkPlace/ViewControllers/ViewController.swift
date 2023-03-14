//
//  ViewController.swift
//  FreeWorkPlace
//
//  Created by Степан Харитонов on 26.10.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Property
    let myView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var variableStartPoint: CGPoint?
    var initialStartPoint: CGPoint?
    let swipeCoordCoef = 0.1
    let myViewSwipeTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        gestureMyViewSettings()
        gestureMyViewSwypeSettings()
        constraintSettings()
        styleSettings()
    }
}

// MARK: Setup subviews
extension ViewController {
    private func constraintSettings() {
        view.addSubview(myView)
        view.addSubview(myView1)
        view.addSubview(myView2)
        view.addSubview(myViewSwipeTop)
        NSLayoutConstraint.activate([
            myView.widthAnchor.constraint(equalToConstant: view.bounds.width/2-15),
            myView.heightAnchor.constraint(equalToConstant: view.bounds.height/3-15),
            myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            myView1.widthAnchor.constraint(equalTo: myView.widthAnchor),
            myView1.heightAnchor.constraint(equalTo: myView.heightAnchor, multiplier: 0.5, constant: -5),
            myView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            myView1.leadingAnchor.constraint(equalTo: myView.trailingAnchor, constant: 10),
            
            myView2.widthAnchor.constraint(equalTo: myView.widthAnchor),
            myView2.topAnchor.constraint(equalTo: myView1.bottomAnchor, constant: 10),
            myView2.bottomAnchor.constraint(equalTo: myView.bottomAnchor),
            myView2.leadingAnchor.constraint(equalTo: myView1.leadingAnchor),
            
            myViewSwipeTop.widthAnchor.constraint(equalTo: view.widthAnchor),
            myViewSwipeTop.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            myViewSwipeTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myViewSwipeTop.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height*swipeCoordCoef)
        ])
    }
 
    // MARK: Style subviews
    private func styleSettings() {
        view.backgroundColor = UIColor.purple
        myView.layer.cornerRadius = 20
        myView.layer.masksToBounds = false
        myView1.layer.cornerRadius = 20
        myView1.layer.masksToBounds = false
        myView2.layer.cornerRadius = 20
        myView2.layer.masksToBounds = false
        myViewSwipeTop.layer.cornerRadius = 40
        let rectCorner: UIRectCorner = [.topLeft, .topRight]
        myViewSwipeTop.layer.maskedCorners = CACornerMask(rawValue: rectCorner.rawValue)
        myViewSwipeTop.layer.masksToBounds = false
    }
}

// MARK: Setup gesture myView
extension ViewController {
    private func gestureMyViewSettings() {
        let tapView = UITapGestureRecognizer()
        tapView.addTarget(self, action: #selector(tapMyView))
        myView.addGestureRecognizer(tapView)
    }
    
    @objc func tapMyView(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.cancelsTouchesInView == true {
            print("Button is enabled")
            animateMyView()
        }
    }
    
    private func animateMyView() {
        UIView.transition(with: myView, duration: 0.5,options: [.beginFromCurrentState, .allowUserInteraction], animations: {self.myView.backgroundColor = UIColor.random})
    }
    private func animateMyView1() {
       
    }
    private func nextController() {
        let next: ViewController2 = ViewController2()
        self.present(next, animated: true)
    }
    
}

//MARK: Setup gesture myViewSwipeTop
extension ViewController {
    private func gestureMyViewSwypeSettings() {
        let panView = UIPanGestureRecognizer()
        panView.maximumNumberOfTouches = 1
        panView.addTarget(self, action: #selector(swipeMyViewSwipe))
        myViewSwipeTop.addGestureRecognizer(panView)
    }

   @objc func swipeMyViewSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
       
       switch gestureRecognizer.state {
            case .began:
                    assert(variableStartPoint == nil)
                    variableStartPoint = gestureRecognizer.location(in: view)
                    initialStartPoint = variableStartPoint
            case .changed:
                    guard let startPoint = variableStartPoint else {assert(false);return}
                    let changedPoint = gestureRecognizer.location(in: view)
                    let differenceStartChanged = startPoint.y - changedPoint.y
                       if self.myViewSwipeTop.center.y >= self.view.frame.height - self.myViewSwipeTop.frame.height/2 {
                               if self.myViewSwipeTop.center.y > self.view.frame.height - self.myViewSwipeTop.frame.height/2 && differenceStartChanged > 0 {
                                   if myViewSwipeTop.center.y - differenceStartChanged > self.view.frame.height - self.myViewSwipeTop.frame.height/2 {
                                       myViewSwipeTop.center.y -= differenceStartChanged
                                   } else if myViewSwipeTop.center.y - differenceStartChanged < self.view.frame.height - self.myViewSwipeTop.frame.height/2 {
                                       myViewSwipeTop.center.y = self.view.frame.height - self.myViewSwipeTop.frame.height/2
                                   } else {
                                       break
                                   }
                                   self.variableStartPoint = changedPoint
                           } else {
                               if self.myViewSwipeTop.center.y < self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef && differenceStartChanged < 0 {
                                   if myViewSwipeTop.center.y - differenceStartChanged < self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef {
                                       myViewSwipeTop.center.y -= differenceStartChanged
                                   } else if myViewSwipeTop.center.y - differenceStartChanged > self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef {
                                       myViewSwipeTop.center.y = self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef
                                   } else {
                                       break
                                   }
                                   self.variableStartPoint = changedPoint
                               }
                           }
                       }
            case .cancelled, .ended:
             guard let startPoint = initialStartPoint else {assert(false);return}
                   let cancelledPoint = gestureRecognizer.location(in: view)
                   let coefPointChangedToBottomView = 1-cancelledPoint.y/view.frame.height
                   let differenceStartCancelled = startPoint.y-cancelledPoint.y
               switch differenceStartCancelled {
                        case _ where (differenceStartCancelled) > 0:
                               if coefPointChangedToBottomView > 0.15 {
                                   UIView.animate(withDuration: 0.3) {
                                       self.myViewSwipeTop.center.y = self.view.frame.height - self.myViewSwipeTop.frame.height/2
                                   }
                               } else if coefPointChangedToBottomView == 0.5 {
                                   break
                               } else {
                                   UIView.animate(withDuration: 0.3) {
                                       self.myViewSwipeTop.center.y = self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef
                                   }
                               }
                               self.variableStartPoint = nil
                               self.initialStartPoint = nil
                        case  _ where (differenceStartCancelled) < 0:
                               if coefPointChangedToBottomView > 0.4 {
                                   UIView.animate(withDuration: 0.3) {
                                       self.myViewSwipeTop.center.y = self.view.frame.height - self.myViewSwipeTop.frame.height/2
                                   }
                               } else if coefPointChangedToBottomView == 0.5 {
                                   break
                               } else {
                                   UIView.animate(withDuration: 0.3) {
                                       self.myViewSwipeTop.center.y = self.view.frame.height + self.myViewSwipeTop.frame.height/2 - self.view.frame.height*self.swipeCoordCoef
                                   }
                               }
                               self.variableStartPoint = nil
                               self.initialStartPoint = nil
                        default: break
                   }
            case .failed, .possible:
                    break
            @unknown default:
                    break
       }
    }
}
