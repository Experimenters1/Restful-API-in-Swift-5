//
//  ViewController.swift
//  test1
//
//  Created by Huy Vu on 2/20/24.
//

import UIKit

struct APIResponse: Codable{
    let total: Int
    let total_pages: Int
    let results: [Result]
}


struct Result: Codable{
    let id: String
    let urls: URLS
}

struct URLS: Codable{
    let regular: String
}


class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return results.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let imageURLString = results[indexPath.row].urls.regular
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            // Configure cell with result data if needed
//            cell.backgroundColor = .blue
            cell.configure(with: imageURLString)
            return cell
        }
    
    
    
    let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=office&client_id=1vEY3UguPxk44VTgEoyaQJOHwMGNKOOKkQWCxSXmXGU"
    
    
    private var collectionView:UICollectionView?
    
    
    var results: [Result] = []
    
   let searchbar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchbar.delegate = self
        view.addSubview(searchbar)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height:view.frame.size.width/2 )
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        fetchPhotos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Thực hiện tác vụ sau khi các view con đã được sắp xếp lại.
        collectionView?.frame = view.bounds
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }

    
    func fetchPhotos(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else{
                return
            }
           
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
//                print(jsonResult.results.count)
                DispatchQueue.main.async {
                    self.results = jsonResult.results
                    self.collectionView?.reloadData() // Reload collection view data
                }
                
            }
            catch {
                print(error)
            }
        }
        

        task.resume()
    }


}

