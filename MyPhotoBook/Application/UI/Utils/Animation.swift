import UIKit

class Pannable: UIViewController {
    var originalPoint: CGPoint = CGPoint.zero
    var currentPoints: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        if panGesture.state == .began {
            originalPoint = view.center
            currentPoints = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(x: translation.x, y: translation.y)
            
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            if velocity.y >= 200 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin = CGPoint(x: self.view.frame.origin.x, y: self.view.frame.size.height)
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPoint
                })
            }
        }
    }
}
