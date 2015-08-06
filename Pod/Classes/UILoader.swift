import UIKit


//MARK: Loading Protocols

@objc public protocol UILoader: NSObjectProtocol
{
    var loading: Bool { get set }
    func didChangeLoadingStatus(loading: Bool)
    optional weak var spinningThing: UIActivityIndicatorView? { get set }
}


//MARK: Extensions

extension UIViewController: UILoader
{
    private var loadingCount: Int {
        get {
            if var result = objc_getAssociatedObject(self, "loadingCount") as? Int {
                return result
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, "loadingCount", newValue, UInt(OBJC_ASSOCIATION_RETAIN) as objc_AssociationPolicy)
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
                self.didChangeLoadingStatus(newValue)
                self.didChangeValueForKey("loading")
            }
        }
    }
    
    public func didChangeLoadingStatus(loading: Bool)
    {
        
    }
}


//MARK: Classes

public class LoadingViewController: UIViewController
{
    @IBOutlet weak var spinningThing: UIActivityIndicatorView?
    
    override public func didChangeLoadingStatus(loading: Bool)
    {
        if loading {
            self.spinningThing?.startAnimating()
        } else {
            self.spinningThing?.stopAnimating()
        }
    }
}
