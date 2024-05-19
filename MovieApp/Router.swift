import UIKit

class Router{
    private let navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func showYellowController() {
        let vc = MovieDetailsViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
