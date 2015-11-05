import UIKit


public protocol UILoader
{
    var _loadingCount: Int { get set }
    var loading: Bool { get set }
    weak var spinningThing: UIActivityIndicatorView? { get }
    func didChangeLoadingStatus(loading: Bool)
}

public extension UILoader
{
    public var loading: Bool {
        get {
            return _loadingCount > 0
        }
        set {
            let oldValue = self.loading
            
            var shouldNotify = false
            
            if newValue {
                shouldNotify = ++_loadingCount == 1
            } else {
                shouldNotify = --_loadingCount == 0
                if _loadingCount < 0 {
                    _loadingCount = 0
                }
            }
            
            if (newValue != oldValue && shouldNotify)
            {
                let status = self.didChangeLoadingStatus
                let thing = self.spinningThing
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if newValue {
                        thing?.startAnimating()
                    } else {
                        thing?.stopAnimating()
                    }
                    status(newValue)
                }
            }
        }
    }
}
