import UIKit
import SnapKit

final class MovieListViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let cellIdentifier = "MovieTableViewCell"
    static let deleteAction = "Delete"
  }
  private let movieListTableView: UITableView = {
    let tableView = UITableView()
    
    tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 212
    
    return tableView
  }()
  
  private var moviesList = [Movie]() {
    didSet {
      movieListTableView.reloadData()
    }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    addSubviews()
    addConstraints()
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    // navigation
    navigationItem.title = "My Movie List"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // tableView
    movieListTableView.delegate = self
    movieListTableView.dataSource = self
    
    // add a navigation button to the trailing side of the menu
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addButtonTapped)
    )
    
    if let movie = CustomUserDefaults.get(key: "DefaultMovie", type: Movie.self) {
      moviesList.append(movie)
    }
    
  }
  
  private func addSubviews() {
    view.addSubview(movieListTableView)
  }
  
  private func addConstraints() {
    movieListTableView.snp.makeConstraints { make -> Void in
      make.top.bottom.leading.trailing.equalTo(view)
    }
  }
  
  // MARK: - Helpers
  @objc private func addButtonTapped() {
    let addMovieVC: AddMovieViewController = AddMovieViewController()
    addMovieVC.eventHandler = { [weak self] movie in
      self?.moviesList.append(movie)
    }
    navigationController?.pushViewController(addMovieVC, animated: true)
  }
  
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moviesList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = movieListTableView
        .dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell {
      cell.setMovieImage(moviesList[indexPath.row].image)
      cell.setMovieTitle(moviesList[indexPath.row].name)
      cell.setMovieRating(moviesList[indexPath.row].getOutOfTenRating(ofSize: 18))
      return cell
    }
    return UITableViewCell()
  }
  
  // selected cell
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movieDetailVC = MovieDetailViewController()
    movieDetailVC.modalPresentationStyle = .fullScreen
    movieDetailVC.setMovieImage(moviesList[indexPath.row].image)
    movieDetailVC.setMovieTitle(moviesList[indexPath.row].name)
    movieDetailVC.setMovieRating(moviesList[indexPath.row].getOutOfTenRating(ofSize: 14))
    movieDetailVC.setMovieYear(moviesList[indexPath.row].releaseDate.getDateAsString(format: "yyyy"))
    movieDetailVC.setMovieDescription(moviesList[indexPath.row].desc)
    movieDetailVC.setMovieWebView(url: moviesList[indexPath.row].youTubeLink)
    
    navigationController?.pushViewController(movieDetailVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: Constants.deleteAction) { (action, view, handler) in
      tableView.beginUpdates()
      self.moviesList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
    }
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
}
