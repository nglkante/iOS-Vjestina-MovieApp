import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class CustomTableViewCell: UITableViewCell {
    
    var movie: MovieModel? {
        didSet {
            guard let movie = movie else{return}
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: URL(string: movie.imageUrl))
            labelName.text = movie.name
            labelSummary.text = movie.summary
        }
      }
    let container = UIView()
    let movieImage = UIImageView()
    let labelName = UILabel()
    let labelSummary = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelSummary.translatesAutoresizingMaskIntoConstraints = false
        
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.shadowOffset = CGSize(width: 100, height: 12)
        container.layer.shadowOpacity = 0.5
        
        addSubview(container)
        container.backgroundColor = .white
        container.autoPinEdge(toSuperviewEdge: .leading, withInset: 16.0)
        container.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16.0)
        container.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5.0)
        container.autoSetDimension(.height, toSize: 142.0)
        
        container.addSubview(movieImage)
        container.addSubview(labelName)
        container.addSubview(labelSummary)
        
        movieImage.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        movieImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        movieImage.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        movieImage.autoSetDimension(.width, toSize: 97)
        
        labelName.textColor = .black
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.numberOfLines = 0
        labelName.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        labelName.autoPinEdge(.left, to: .right, of: movieImage, withOffset: 16)
        labelName.autoPinEdge(toSuperviewEdge: .right, withInset: 12)

        labelSummary.textColor = .systemGray3
        labelSummary.font = UIFont(name: "ProximaNova", size: 14)
        labelSummary.numberOfLines = 0
        labelSummary.autoPinEdge(.top, to: .bottom, of: labelName, withOffset: 8)
        labelSummary.autoPinEdge(.left, to: .right, of: movieImage, withOffset: 16)
        labelSummary.autoPinEdge(toSuperviewEdge: .right, withInset: 12)
        labelSummary.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
