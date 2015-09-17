import UIKit


//MARK: Loading Protocols

@objc public protocol UILoader: NSObjectProtocol
{
    var loading: Bool { get set }
    func didChangeLoadingStatus(loading: Bool)
    weak var spinningThing: UIActivityIndicatorView? { get set }
}


//MARK: Extensions

extension UIViewController: UILoader
{
    private var loadingCount: Int {
        get {
            if let result = objc_getAssociatedObject(self, "loadingCount") as? Int {
                return result
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, "loadingCount", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBOutlet weak public var spinningThing: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, "spinningThing") as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, "spinningThing", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var loading: Bool {
        get {
            return loadingCount > 0
        }
        set {
            let oldValue = self.loading
            
            if newValue {
                loadingCount += 1
            } else {
                loadingCount -= 1
                if loadingCount < 0 {
                    loadingCount = 0
                }
            }
            
            if (!oldValue && !newValue) || (newValue != oldValue)
            {
                self.willChangeValueForKey("loading")
                dispatch_async(dispatch_get_main_queue(), { [unowned self] () -> Void in
                    if !newValue {
                        self.spinningThing?.stopAnimating()
                    } else {
                        self.spinningThing?.startAnimating()
                    }
                    self.didChangeLoadingStatus(newValue)
                })
                self.didChangeValueForKey("loading")
            }
        }
    }
    
    public func didChangeLoadingStatus(loading: Bool)
    {
        
    }
}
