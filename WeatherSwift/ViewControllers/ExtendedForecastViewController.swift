//
//  ExtendedForecastViewController.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import UIKit

class ExtendedForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PopupDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var selectedRow: IndexPath = []
    var arrayWeather: [MyWeather] = []
    var refreshControl = UIRefreshControl()
    var todayFiltered, tommorowFiltered, oneDayLaterFiltered, twoDaysLaterFiltered, threeDaysLatterFiltered: [List]?
    
    func popupClosed() {
        
        refresh()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath
        
        tableView.beginUpdates()
        tableView.rowHeight = 160
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath == selectedRow && tableView.rowHeight !=  -1){
            return tableView.rowHeight
        }
        
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIndetifier", for: indexPath)
            as! TableViewCell
    
        cell.commonInit(day: arrayWeather[indexPath.row].titleString, maxTemp: arrayWeather[indexPath.row].maxTempString, minTemp: arrayWeather[indexPath.row].minTempString, icon: arrayWeather[indexPath.row].icon, additional: arrayWeather[indexPath.row].descriptionByTime)

        return cell
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        
        let popup = PopupViewController.create()
        let sbPopup = SBCardPopupViewController(contentViewController: popup)
        
        sbPopup.show(onViewController: self)
        PopupViewController.shared.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.mainTableView.register(nib, forCellReuseIdentifier: "CellIndetifier")
        
        makeRequest()
        
        //swipe down
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mainTableView.addSubview(refreshControl)
    
        //Добавляем свайп назад
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(sender:)))
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(rightSwipe)
    }
    
    func makeRequest(){
        
        let myCalendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let weekDay = myCalendar.component(.weekday, from: Date())
        
        let tommorowDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let oneDayLaterDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let twoDaysLaterDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
        let threeDaysLatterDate = Calendar.current.date(byAdding: .day, value: 4, to: Date())!
        
        let todayDateString = dateFormatter.string(from: Date())
        let tommorowDateString = dateFormatter.string(from: tommorowDate)
        let oneDayLaterDateString = dateFormatter.string(from: oneDayLaterDate)
        let twoDaysLaterDateString = dateFormatter.string(from: twoDaysLaterDate)
        let threeDaysLatterDateString = dateFormatter.string(from: threeDaysLatterDate)
        
        API.get(city: Settings.City.cityForUrlName, url: Settings.API.URLFewDays, completHandler: { response in
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {

                self.cityLabel.text = Settings.City.cityForDisplayName
                
                self.todayFiltered = response?.list?.filter({($0.dtTxt?.contains(todayDateString))!})
                self.tommorowFiltered = response?.list?.filter({($0.dtTxt?.contains(tommorowDateString))!})
                self.oneDayLaterFiltered = response?.list?.filter({($0.dtTxt?.contains(oneDayLaterDateString))!})
                self.twoDaysLaterFiltered = response?.list?.filter({($0.dtTxt?.contains(twoDaysLaterDateString))!})
                self.threeDaysLatterFiltered = response?.list?.filter({($0.dtTxt?.contains(threeDaysLatterDateString))!})
        
                self.addRow(day: DateOperations.getDayOfWeek(index: weekDay), filtered: self.todayFiltered!)
                self.addRow(day: DateOperations.getDayOfWeek(index: weekDay + 1), filtered: self.tommorowFiltered!)
                self.addRow(day: DateOperations.getDayOfWeek(index: weekDay + 2), filtered: self.oneDayLaterFiltered!)
                self.addRow(day: DateOperations.getDayOfWeek(index: weekDay + 3), filtered: self.twoDaysLaterFiltered!)
                self.addRow(day: DateOperations.getDayOfWeek(index: weekDay + 4), filtered: self.threeDaysLatterFiltered!)
            })
        }, errorHandler: { error in
            
            let alert = UIAlertController(title: "Ошибка", message: "Произошла неизвестная ошибка", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func addRow(day: String, filtered: [List]) -> Void {
        
        let maxTemperature = (filtered.max(by: { (item1, item2) -> Bool in
            return item1.main!.temp! < item2.main!.temp!
        })?.main?.temp)! - 273
        let minTemperature = (filtered.min(by: { (item1, item2) -> Bool in
            return item1.main!.temp! < item2.main!.temp!
        })?.main?.temp)! - 273
        
        // должно возвращать default иконку
        let iconWeather = IconOperations.getIcon(iconPath: filtered.first?.weather?.first?.icon ?? "01d")
        
        //TODO Придумать как сделать замыканием
        var additionalDescription = [Additional]()
        
        for item in filtered{
            let splitedTime = item.dtTxt?.split(separator: " ").last?.split(separator: ":").first
            
            additionalDescription.append(Additional(additionalTimeString: String(splitedTime!), additionalIcon: IconOperations.getIcon(iconPath: (item.weather?.first?.icon)!), additionalDegreesString: String(format:"%.0f", (item.main?.temp!)! - 273)))
        }
        
        let element = MyWeather(icon: iconWeather, titleString: day, maxTempString: String(format:"%.0f",maxTemperature), minTempString:String(format:"%.0f", minTemperature), descriptionByTime: additionalDescription)
        
        self.arrayWeather.insert(element, at: self.arrayWeather.count)
        self.mainTableView.beginUpdates()
        self.mainTableView.reloadRows(at: self.mainTableView.indexPathsForVisibleRows ?? [], with: .automatic)
        self.mainTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
        self.mainTableView.endUpdates()
    }
    
    @objc func refresh(){
        
        arrayWeather = []
        makeRequest()
        mainTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func handelSwipe(sender: UISwipeGestureRecognizer){
        
        if let navigateBack = self.navigationController {
            navigateBack.popViewController(animated: true)
        }
    }
}
