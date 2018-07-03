//
//  ViewController.swift
//  HelnanProject
//
//  Created by Mahmoud on 5/31/18.
//  Copyright © 2018 CyanDH. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class HotelsVC: UIViewController {
    var hotelid:Int?
    var imageHotel  = [String]()
   let cellIdentefier = "HotelCel"
  var hotels = [GetHotelsTV]()
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Hotels"
        tableview.tableFooterView = UIView()
        tableview.separatorInset = .zero
        tableview.contentInset = .zero
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentefier)
        tableview.dataSource = self
        tableview.delegate = self
        handleRefresh()
        tableview.backgroundColor = UIColor.clear
        tableview.addSubview(refresher)
        tableview.showsVerticalScrollIndicator = false
    }

    @objc func handleRefresh() {
        refresher.endRefreshing()
        GetAllHotels.getHotels { (error: Error?, hotels: [GetHotelsTV]?) in
            if let hotels = hotels {
                self.hotels = hotels
                    self.tableview.reloadData()
            }
        }
            self.tableview.reloadData()
    }
}
extension HotelsVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableview.dequeueReusableCell(withIdentifier: "HotelsCell", for: indexPath)
            as? HotelsCell
        cell?.hotelName.text = hotels[indexPath.row].name
       cell?.hotelName.textAlignment = .center
        let urlimage = URL(string: hotels[indexPath.row].icon)
        cell?.imageHotel.kf.setImage(with: urlimage)
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = UITableViewCellSelectionStyle.none

        return cell!
        
    }
}
extension HotelsVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 150
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         hotelid = hotels[indexPath.row].id
        imageHotel = hotels[indexPath.row].hotelImages
        performSegue(withIdentifier: "hotelSection", sender: (hotelid: hotelid, imageHotel: imageHotel) )

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HotelsGetInfo {
            destination.hotelID =  hotelid ?? 0
            destination.hotelImages = imageHotel
        }
    }
}
