//
//  Extensions.swift
//  RestoMVVM
//
//  Created by macexpert on 15/02/21.
//

import UIKit

// MARK: - UIApplication
extension UIApplication {
    
    class var scene: UIViewController! {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.window?.rootViewController
    }
    
    class var appWindow: UIWindow! {
        return (UIApplication.shared.delegate?.window!)!
    }
    
    class var rootViewController: UIViewController! {
        if #available(iOS 13.0, *) {
            return self.scene
        }
        return self.appWindow.rootViewController!
    }
    
    class var visibleViewController: UIViewController! {
        return self.rootViewController.findContentViewControllerRecursively()
    }
    
}

// MARK: - View Controller
extension UIViewController {
    
    func isPresentedModally() -> Bool {
        return self.presentingViewController?.presentedViewController == self
    }
    
    func pushControl(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func popOrDismissViewController(_ animated: Bool) {
          if self.isPresentedModally() {
              self.dismiss(animated: animated, completion: nil)
          } else if self.navigationController != nil {
              _ = self.navigationController?.popViewController(animated: animated)
          }
      }
    
    func customAddChildViewController(_ child: UIViewController, toSubview subview: UIView) {
        self.addChild(child)
        subview.addSubview(child.view)
        child.view.addConstraintToFillSuperview()
        child.didMove(toParent: self)
    }
    
    func findContentViewControllerRecursively() -> UIViewController {
        var childViewController: UIViewController?
        if self is UITabBarController {
            childViewController = (self as? UITabBarController)?.selectedViewController
        } else if self is UINavigationController {
            childViewController = (self as? UINavigationController)?.topViewController
        } else if self is UISplitViewController {
            childViewController = (self as? UISplitViewController)?.viewControllers.last
        } else if self.presentedViewController != nil {
            childViewController = self.presentedViewController
        }
        let shouldContinueSearch: Bool = (childViewController != nil) && !((childViewController?.isKind(of: UIAlertController.self))!)
        return shouldContinueSearch ? childViewController!.findContentViewControllerRecursively() : self
    }
    
    func customRemoveFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

// MARK: - Storyboard
extension UIStoryboard {
    
    class var main: UIStoryboard {
        let storyboardName: String = (Bundle.main.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String)!
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

// MARK: - Dispatch
extension DispatchQueue {
    
    class func dispatch_async_main(_ block: @escaping () -> Void) {
        self.main.async(execute: block)
    }
}

// MARK: - UIView
extension UIView {
    
    var isVisible: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }

    func addVisualConstraints(_ constraints: [String], subviews: [String: UIView]) {
        addVisualConstraints(constraints, metrics: nil, subviews: subviews)
    }
    
    func addConstraintForAspectRatio(_ aspectRatio: CGFloat) -> NSLayoutConstraint {
           let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: aspectRatio, constant: 0.0)
           addConstraint(constraint)
           return constraint
       }
    
    func addVisualConstraints(_ constraints: [String], metrics: [String: Any]?, subviews: [String: UIView]) {
        // Disable autoresizing masks translation for all subviews
        for subview in subviews.values {
            if subview.responds(to: #selector(setter: self.translatesAutoresizingMaskIntoConstraints)) {
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        // Apply all constraints
        for constraint in constraints {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: metrics, views: subviews))
        }
    }
    
    func addConstraintToFillSuperview() {
        superview?.addVisualConstraints(["H:|[self]|", "V:|[self]|"], subviews: ["self": self])
    }
    
    func addConstraintSameCenterX(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .centerX, att2: .centerX, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameCenterY(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .centerY, att2: .centerY, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameCenterXY(_ view1: UIView, and view2: UIView) {
        addConstraintSameCenterX(view1, view2: view2)
        addConstraintSameCenterY(view1, view2: view2)
    }
    
    func addConstraint(_ view1: UIView, view2: UIView, att1: NSLayoutConstraint.Attribute, att2: NSLayoutConstraint.Attribute, mul: CGFloat, const: CGFloat) -> NSLayoutConstraint {
        if view2.responds(to: #selector(setter: self.translatesAutoresizingMaskIntoConstraints)) {
            view2.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: view1, attribute: att1, relatedBy: .equal, toItem: view2, attribute: att2, multiplier: mul, constant: const)
        addConstraint(constraint)
        return constraint
    }
    
    func applyGradient() {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [
            UIColor.init(white: 1, alpha: 0).cgColor,
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        ]
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Alert Controller
extension UIAlertController {
    
    // Shows alert view with completion block
    class func showAlert(_ title: String, message: String, buttons: [String], completion: ((UIAlertController, Int) -> Void)?) {
        let alertView: UIAlertController? = self.init(title: title, message: message, preferredStyle: .alert)
        for i in 0..<buttons.count {
            alertView?.addAction(UIAlertAction(title: buttons[i], style: .default, handler: {(_ action: UIAlertAction) -> Void in
                if completion != nil {
                    completion!(alertView!, i)
                }
            }))
        }
        if #available(iOS 13.0, *) {
            UIApplication.scene.present(alertView!, animated: true, completion: nil)
        } else {
            UIApplication.visibleViewController.present(alertView!, animated: true, completion: nil)
        }
    }
}
