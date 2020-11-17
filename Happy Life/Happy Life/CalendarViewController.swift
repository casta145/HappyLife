//
//  CalendarViewController.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 11/28/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

var dateString = ""

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September","October", "November", "December"]
    
    let DaysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    var NumberOfEmptyBox = Int() //Number of Empty Boxes at the start of the current month
    var NextNumberOfEmptyBox = Int() //Number of Empty Boxes at the start of the next month
    var PreviousNumberOfEmptyBox = 0 //Number of Empty Boxes of the previous month
    var Direction = 0 //=0 current month; =1 next month; =-1 previous month
    var PositionIndex = 0 //store the above vars of the empty boxes
    var LeapYearCt = 2 //next time feb has 29 days is in two years (happens every 4 years)
    var dayCt = 0
    var highlightdate = -1
    var cellsArray: [UICollectionViewCell]  = []
    var myindex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        if weekday == 0 {
            weekday = 7
        }
        GetStartDayDatePosition()
        
    
    }
    
    @IBAction func Next(_ sender: UIButton) {
        highlightdate = -1
        switch currentMonth {
        case "December":
            Direction = 1
            month = 0
            year += 1
            if LeapYearCt < 5 {
                LeapYearCt += 1
            }
            if LeapYearCt == 4 {
                DaysInMonth[1] = 29
            }
            if LeapYearCt == 5 {
                LeapYearCt = 1
                DaysInMonth[1] = 28
            }
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationNext(Label: MonthLabel)
            Calendar.reloadData()
        default:
            Direction = 1
            GetStartDayDatePosition()
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationNext(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: UIButton) {
        highlightdate = -1
        switch currentMonth {
        case "January":
            Direction = -1
            month = 11
            year -= 1
            if LeapYearCt > 0 {
                LeapYearCt -= 1
            }
            if LeapYearCt == 0 {
                DaysInMonth[1] = 29
                LeapYearCt = 4
            } else {
                DaysInMonth[1] = 28
            }
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
        default:
            Direction = -1
            month -= 1
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    
    @IBAction func exit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func GetStartDayDatePosition(){ //Function gives us the number of empty boxes
        switch Direction{
        case 0: //if we are at the current month
            NumberOfEmptyBox = weekday
            dayCt = day
            while dayCt > 0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                dayCt = dayCt - 1
                if NumberOfEmptyBox == 0 {
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...: //if we are at the next month
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonth[month]) % 7
            PositionIndex = NextNumberOfEmptyBox
        case -1: //if we are in the previous month
            PreviousNumberOfEmptyBox = (7 - (DaysInMonth[month] - PositionIndex) % 7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{ //returns number of days in the month and its empty boxes
        case 0:
            return DaysInMonth[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonth[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonth[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        cell.Circle.isHidden = true
        
        if cell.isHidden{
            cell.isHidden = false
        }
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 { //Hides every cell that comes back negative
            cell.isHidden = true
        }
        
        //Showing weekend days in different colors
        switch indexPath.row { //Indexes of the collectionview that matches with the weekend days in every month
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.gray
            }
        default:
            break
        }
        
        //Marks the cell showing the current day in cyan
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == day {
            
            cell.Circle.isHidden = false
            cell.DrawCricle()
        }
        
        if highlightdate == indexPath.row {
            cell.backgroundColor = UIColor(displayP3Red: 0.45, green: 0.67, blue: 0.27, alpha: 1.0)
        }
        
        cellsArray.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dateString = "\(indexPath.row - PositionIndex + 1) \(currentMonth) \(year)"
        
        performSegue(withIdentifier: "NextView", sender: self)
        
        highlightdate = indexPath.row
        savedDates.append(dateString)
        
        collectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        for x in cellsArray {
            let cell : UICollectionViewCell = x
            UIView.animate(withDuration: 1, delay: 0.01 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
                })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "eventCell")
        tableCell.textLabel?.text = savedDates[indexPath.row]
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myindex = indexPath.row
    }
    
    func popUp(_: Int) {
        let alert = UIAlertController(title: "Event: ", message: "\(savedEvent[myindex])", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
}
