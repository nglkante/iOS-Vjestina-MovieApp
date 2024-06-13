import UIKit
import MovieAppData
import PureLayout
import Kingfisher

class MovieListViewController: UIViewController {
    var allMovies: [MovieModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor(.black)]
        appearance.largeTitleTextAttributes = [.backgroundColor: UIColor(.white)]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "Movie list"
        allMovies = MovieUseCase().allMovies
        let tableView = UITableView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height))
        tableView.rowHeight = 150
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.dataSource = self
    }
}
extension MovieListViewController: UITableViewDataSource,UITableViewDelegate { // 3.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath) as! CustomTableViewCell// 4.
        let movie = allMovies[indexPath.row]
        cell.set(movie: movie)
        return cell
    }
}
