//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Fnu Tsering on 2/19/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]! //declaring the variable movie as a dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit() //after setting the text, this tells the label to grow the label until it can fit everything in the label.
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit() 
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        //this function .af_setImage(withURL: URL) from the pod AlomofireImage downloads the images from the posterURL
        //and sets those images in the posterView/imageView according to the correspondong movies
        posterView.af.setImage(withURL: posterUrl)
        
        //setting image for the backdrop view
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)! //we changed the photo resolution in the baseURL here so we can get better resolution photo for the backdrop
        
        //this function .af_setImage(withURL: URL) from the pod AlomofireImage downloads the images from the posterURL
        //and sets those images in the posterView/imageView according to the correspondong movies
        backdropView.af.setImage(withURL: backdropUrl)
        
        
    }
    

    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
