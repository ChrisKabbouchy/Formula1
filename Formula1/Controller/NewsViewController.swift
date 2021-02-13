//
//  NewsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 17/01/2021.
//

import UIKit

class NewsViewController: UIViewController ,UITableViewDelegate{

    @IBOutlet var newsTableView: UITableView!
    
    var newsModel : [NewsModel]?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchNews()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: -Table view

extension NewsViewController :  UITableViewDataSource ,FormulaMangerDelegate ,ImageLoaderDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageLoader = ImageLoader(imageString: newsModel?[indexPath.row].imageUrl)
        imageLoader.delegate = self
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.newsImage.image = imageLoader.image
        cell.newsImage.layer.cornerRadius = 10
        cell.newsLabel.text = newsModel?[indexPath.row].title
        return cell
    }
    
    //MARK: -Segue to News Highlights
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToHighlightNews", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newsVC = segue.destination as! NewsHighlightViewController
        let index = newsTableView.indexPathForSelectedRow
        newsVC.newsModel = newsModel?[index!.row]
    }
    
    //MARK: -Formula Manager delegate
    
    func newsDataDidLoad (newsModel : [NewsModel]){
        self.newsModel = newsModel
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    func errorOccurred(error:Error){
        let alertController = UIAlertController(
            title: "Error Occured",
            message:error.localizedDescription,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: -Image Loader Delegate
    
    func imageDidLoad(image: UIImage) {
        self.image = image
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
}
