//
//  ViewController.swift
//  Youtube Clone
//
//  Created by Mufti Ramdhani on 15/03/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
  
  var model = Model()
  var videos = [Video]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    tableView.dataSource = self
    tableView.delegate = self
    model.delegate = self
    
    model.getVideo()
  }

  func videosFatched(_ videos: [Video]) {
    
    self.videos = videos
    
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return videos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Contsants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
    
    let video = self.videos[indexPath.row]
    
    cell.setCell(video)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // ngecek ada video yang dipilih
    guard tableView.indexPathForSelectedRow != nil else {
      return
    }
    
    // buat variabel video yang dipilih
    let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
    
    // buat variabel untuk halaman detail
    let detailVC = segue.destination as! DetailViewController
    
    detailVC.video = selectedVideo
  }
}

