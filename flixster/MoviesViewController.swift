//
//  MoviesViewController.swift
//  flixster
//
//  Created by Fnu Tsering on 2/11/21.
//

import UIKit
import AlamofireImage //the library/pod we downloaded through cocoapods

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]()
    
    //viewDidLoad() is a special function that runs the first time that a screen comes up.
    //Stuff that you put in this function is called as soon as the screen assoicated to this class comes up.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        
        //downloads data requested from this url
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data { //the data returned by the API is 5 key-value pairs, which is stored in this dictionary variable dataDictionary.
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            //In order to get just the list of movies from the data returned by the API, we only need the values of the results key. In order to access just the results key from the dictionary, we can use the dictionary[key] notation to get just the values of that particular key.
            //[String:Any] -> this is the notation to declare a dictionary
            //[[String:Any]] -> this is the notation to declare an array of dictionaries.
            //Since the values of the results key is an array of dictionaries, we declared the variable movies as an array of dictionaries to store the data of the results key in variable movies.
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.tableView.reloadData() //calls on the table view functions 
            
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    //In order to work with a Table View, you need these 2 tableView functions. These functions are automatically called when you go to the screen with the table view just like how viewDidLoad() is called.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this function is asking to return a number of rows.
        //For our app, we will need to return the count of the movies for the number of rows because we will need one row for each movie in the scroll list.
        return movies.count;
     
    }
    //this tableView function lets you customize the cell for each row.
    //indexPath.row gives the value of each row from 0.
    //this function for the cells gets called the amount of time as the numbers of rows. So if the tableView function for rows returns 50 rows, then this function will get called 50 times.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String

        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        //this function .af_setImage(withURL: URL) from the pod AlomofireImage downloads the images from the posterURL
        //and sets those images in the posterView/imageView according to the correspondong movies
        cell.posterView.af.setImage(withURL: posterUrl)
        
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up the details screen")
        
        //Find the selected movie
        let cell  = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the MovieDetails view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
