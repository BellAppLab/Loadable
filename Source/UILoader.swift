import UIKit


private class UILoaderItem
{
    weak var item: UILoader?
    var count: Int = 0
    init(item: UILoader) {
        self.item = item
    }
    
    private static var all = [UILoaderItem]()
    
    static func find(_ item: UILoader) -> UILoaderItem?
    {
        for existing in all {
            if let tempItem = existing.item {
                if tempItem.isEqual(item) {
                    return existing
                }
            }
        }
        return nil
    }
    
    static func make(_ item: UILoader) -> UILoaderItem
    {
        if let found = find(item) {
            return found
        }
        all.append(UILoaderItem(item: item))
        return all.last!
    }
}


@objc public protocol UILoader: NSObjectProtocol
{
    func didChangeLoadingStatus(_ loading: Bool)
    @objc optional weak var activityIndicatorView: UIActivityIndicatorView? { get }
}


public extension UILoader
{
    public var isLoading: Bool {
        get {
            return UILoaderItem.make(self).count > 0
        }
        set {
            let oldValue = self.isLoading
            let loaderItem = UILoaderItem.make(self)
            
            var shouldNotify = false
            
            if newValue {
                loaderItem.count += 1
                shouldNotify = loaderItem.count == 1
            } else {
                loaderItem.count -= 1
                shouldNotify = loaderItem.count == 0
                if loaderItem.count < 0 {
                    loaderItem.count = 0
                }
            }
            
            if (newValue != oldValue && shouldNotify)
            {
                let status = self.notifyStatusChange
                DispatchQueue.main.async {
                    status(newValue)
                }
            }
        }
    }
    
    private func notifyStatusChange(newValue: Bool) {
        if newValue {
            self.activityIndicatorView??.startAnimating()
        } else {
            self.activityIndicatorView??.stopAnimating()
        }
        self.didChangeLoadingStatus(newValue)
    }
}
