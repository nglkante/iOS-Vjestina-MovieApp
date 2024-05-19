import UIKit

class Router{
    private let navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func showMovieDetails(movieID: Int) {
        let vc = MovieDetailsViewController(movieID: movieID)
        navigationController.present(vc, animated: true)
    }
}
