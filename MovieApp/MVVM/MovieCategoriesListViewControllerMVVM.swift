import UIKit
import Combine
import PureLayout
import Kingfisher

class MovieCategoriesListViewControllerMVVM: UIViewController {
    private let cellIdentifier = "cellId"
    private var popularCollectionView: UICollectionView!
    private var freeToWatchCollectionView: UICollectionView!
    private var trendingCollectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private var viewModel: MovieCategoriesListViewModel!
    private var disposables = Set<AnyCancellable>()
    private let router: Router!

    init(viewModel: MovieCategoriesListViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovies() 
        gotData()
        setupView()
        bindViewModel()
    }

    private func gotData(){
        viewModel.onGotData = { [weak self] in
            DispatchQueue.main.async {
                self?.popularCollectionView.reloadData()
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Movie list"

        let darkBlue = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)

        let popularLabel = UILabel()
        popularLabel.text = "What's popular"
        popularLabel.textColor = darkBlue
        popularLabel.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(popularLabel)
        popularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 24)
        popularLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8

        popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        popularCollectionView.backgroundColor = .white
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellA")
        view.addSubview(popularCollectionView)
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.autoPinEdge(.top, to: .bottom, of: popularLabel, withOffset: 16)
        popularCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        popularCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: -10)
        popularCollectionView.autoSetDimension(.height, toSize: 142.0)

        let freeToWatchLabel = UILabel()
        freeToWatchLabel.text = "Free to Watch"
        freeToWatchLabel.textColor = darkBlue
        freeToWatchLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(freeToWatchLabel)
        freeToWatchLabel.autoPinEdge(.top, to: .bottom, of: popularCollectionView, withOffset: 40)
        freeToWatchLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)

        freeToWatchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        freeToWatchCollectionView.backgroundColor = .white
        freeToWatchCollectionView.dataSource = self
        freeToWatchCollectionView.delegate = self
        freeToWatchCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellB")
        view.addSubview(freeToWatchCollectionView)
        freeToWatchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        freeToWatchCollectionView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel, withOffset: 16)
        freeToWatchCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        freeToWatchCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: -10)
        freeToWatchCollectionView.autoSetDimension(.height, toSize: 142.0)

        let trendingLabel = UILabel()
        trendingLabel.text = "Trending"
        trendingLabel.textColor = darkBlue
        trendingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(trendingLabel)
        trendingLabel.autoPinEdge(.top, to: .bottom, of: freeToWatchCollectionView, withOffset: 40)
        trendingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)

        trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        trendingCollectionView.backgroundColor = .white
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellC")
        view.addSubview(trendingCollectionView)
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollectionView.autoPinEdge(.top, to: .bottom, of: trendingLabel, withOffset: 16)
        trendingCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        trendingCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: -10)
        trendingCollectionView.autoSetDimension(.height, toSize: 142.0)
    }

    private func bindViewModel() {
        viewModel.$popularMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.popularCollectionView.reloadData()
            }
            .store(in: &disposables)

        viewModel.$trendingMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.trendingCollectionView.reloadData()
            }
            .store(in: &disposables)

        viewModel.$freeToWatchMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.freeToWatchCollectionView.reloadData()
            }
            .store(in: &disposables)
    }

    func showMovieDetails(movieID: Int) {
        router.showMovieDetails(movieID: movieID)
    }
}

extension MovieCategoriesListViewControllerMVVM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case popularCollectionView:
            return viewModel.popularMovies.count
        case freeToWatchCollectionView:
            return viewModel.ftwMovie.count
        case trendingCollectionView:
            return viewModel.trendingMovies.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
//        case popularCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! CategoryCell
//            cell.movie = viewModel.movie(at: indexPath, for: .freeToWatch)
//            return cell
        case freeToWatchCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellB", for: indexPath) as! CategoryCell
            let movie = viewModel.ftwMovie[indexPath.row]
            cell.movie = movie
            return cell
//        case trendingCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellC", for: indexPath) as! CategoryCell
//            cell.movie = viewModel.movie(at: indexPath, for: .trending)
//            return cell
        default:
            fatalError("Unexpected collection view")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieID: Int
        switch collectionView {
        case popularCollectionView:
            movieID = viewModel.popularMovies[indexPath.row].id
        case freeToWatchCollectionView:
            movieID = viewModel.ftwMovie[indexPath.row].id
        case trendingCollectionView:
            movieID = viewModel.trendingMovies[indexPath.row].id
        default:
            return
        }
        showMovieDetails(movieID: movieID)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 179)
    }
}
