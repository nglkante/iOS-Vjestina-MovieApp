import UIKit

extension UIFont {

    func boldFont() -> UIFont? {
        guard let boldDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) else {
            return nil
        }

        return UIFont(descriptor: boldDescriptor, size: pointSize)
    }

}
