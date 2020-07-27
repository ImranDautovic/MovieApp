//
//  TableViewController.swift
//  MovieApp
//
//  Created by Pick Jobs on 7/20/20.
//  Copyright © 2020 Pick Jobs. All rights reserved.
//

import UIKit

//Class Movies with a properties that we are going to take from an API and initialization of properties
class Movies {
    
    var original_title: String
    var vote_average: Double
    var poster_path: String
    var title1: String
    var overview1: String
    
    init(_ dictionary: [String : Any]){
        self.vote_average = (dictionary["vote_average"] as? Double) ?? 3.0
        self.original_title = (dictionary["original_title"] as? String) ?? ""
        self.poster_path = (dictionary["poster_path"] as? String) ?? ""
        self.title1 = (dictionary["title"] as? String) ?? ""
        self.overview1 = (dictionary["overview"] as? String) ?? ""
    }
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectedItems{
    
    //MARK: - Outlet Connections-
    
    @IBOutlet var mainTableView: UITableView!
    
    var movie: Movies? //Making an object that is type of Movies wich is an optional
    
    var title2: String {
        return movie?.title1 ?? ""  //Return a title for delegate in LastViewController
    }
    
    var overview2: String {
        return movie?.overview1 ?? ""  //Return a overview for delegate in LastViewController
    }
    
    //Filling with data gotten from for loop
    var movies = [Movies]() {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    let baseURL: String = "https://api.themoviedb.org"
    let key: String = "c8c0d2711c3623dea36e99927ea4acb7"
    
    //MARK: - View Controller Life Cycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //API Request
        let url: URL = URL (string: "\(baseURL)/3/movie/top_rated?api_key=\(key)&language=en-US&page=1")!
        let session = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            print("Movies")
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                    //API has a lot of data, so we need it to take from "results"
                    if let results = jsonResponse["results"] as? [[String : Any]]  {
                        for (index,result) in results.enumerated() {
                            if (index<10){
                                let movie = Movies(result)
                                self.movies.append(movie) //Adding data inside of observer variable movies
                            } else {
                                break
                            }
                        }
                    }
                }
            } catch let parsingError {
                print ("Error", parsingError)
            }
        })
        session.resume()
        
        //Registration of Table View cell
        self.mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        
        //Implementation of Delegate and Data Source
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
    }
    
    //MARK: - Functions for Delegate and Data Source -
    
    //Function for height of each row in our section
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    //Function for number of sections, in our case its just one
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Function for number of rows in section, thats calling everytime when function "numberOfSections" is called
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    //Function that follows and performs some action when a user click on a certain row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMovie = self.movies[indexPath.row]
        self.movie = selectedMovie
        
        //Creating a Storyboard and View Controller for switching to another screen after a certain row is clicked
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: LastViewController = storyboard.instantiateViewController(identifier: "LastViewController")
        
        viewController.delegateNew = self //Implementation of delegate
        self.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = self.movies[indexPath.row]
        
        let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell // loading a cell that we made as a .xib file
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movie.poster_path)")
        
        cell.titleLabel.text = movie.original_title  //Printing an original_title thats requested from API
        cell.voteLabel.text = String(movie.vote_average) //Printing a vote_average thats requested from API
        
        //Presenting an ImageView that we are getting from API
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.firstImageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
}
