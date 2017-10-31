//
//  EventDetailViewController.swift
//  
//
//  Created by Francis Zamora on 3/22/17.
//
//

import Foundation
import UIKit
import QuartzCore
import SwiftyJSON

class EventDetailViewController: SetGovTableViewController, EventAgendaCallback, EventInfoCallback, EventStreamCallback, CommentCallBack, DiscussionCallBack, AttendCellCallBack {
    var activate = true
    var infoCell = true
    var memberCell = true
    var numsections = 0
    var animateView: Bool = false
    var selectedEvent = ""
    var selectedEvents = [String]()
    var indexofEvent = 0
    var eventList = [Int:String]()
    var eventImages = [Int: UIImage]()
    var agendaImage = #imageLiteral(resourceName: "Image1")
    var dataList = [Event]()
    var eventInfo = [Int: [String]]()
    var eventTitle = "Marine Advisory"
    var agendaInfo = [Int: String]()
    var Index = 0
    var selectedCity = " "
    var currentTime = " "
    var refresher: UIRefreshControl!
    var noAlert = false
    var videoRequested = false
    var streamPressed = false
    var timeArray = [String]()
    var eventTime = [String]()
    var arrayEvents = [String]()
    var eventTimeNoFormat = [String]()
    var eventHours = [[String]()]
    var EventAddresses = [String]()
    var hrefArray = [String]()
    var descriptionArray = [String]()
    var fortlauderdaleArray = [[String()]]
    var eventDescription = String()
    var paragraphArray = [[String()]]
    var agendaTitle = [String]()
    var currentEvent: Event!
    weak var collectionView: UICollectionView!
    var picArray = [String]()
    var currentHour = String()
    var user: User!
    var replyComment: Comment!
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    var userArray = [User]()
    var currentEventStream: EventLiveStream?

    @IBOutlet var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.user = self.appDelegate.user
        refresher = UIRefreshControl()
        
        super.viewDidLoad()
        
        addButton()
        
        self.loadTitle()
        
        self.refresher?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    
    }
    
    func addButton() {
        let button = UIButton(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: view.frame.width, height: 200))
        self.view.addSubview(button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchEvent()

        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let stream = currentEventStream {
            currentEventStream = nil
        }
    }
    
    func checkAlert() -> Bool {
        if videoRequested == true {
            return true
        }
        else {
            return false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set("off", forKey: eventTitle)
    }
    
    func fetchEvent() {
        if selectedCity == "Boston" {

            ApiClient.fetchEvent(eventID:self.currentEvent.id , onCompletion:{ json in
                self.userArray = []
                let attendees = json["data"]["event"]["attendingUsers"].array
                for users in attendees! {
                    if let fullName = users["full_name"].string,
                        let profileURL = users["profileImage"]["url"].string {
                        self.userArray.append(User(fullName: fullName, profilePictureURL: profileURL))
                    }
                }
                
                self.currentEvent.users = self.userArray
            
          
                guard let comments = json["data"]["event"]["comments"].array else {
                    return
                }
                
                self.currentEvent.comments = []
                for (_,val)in comments.enumerated()  {
                    print("this is val")
                    print(val)
                   
                    let user = User(fullName: val["user"]["full_name"].stringValue,
                                    profilePictureURL: val["user"]["profileImage"]["url"].stringValue)
                    let comment = Comment(text: val["text"].stringValue, user: user, karma: val["karma"].int!, timeStamp: "1 min ago",commentID:val["id"].int!)
                    
                    self.currentEvent.comments.append(comment)
                   
                    //print("here is the text")
                }
                
                self.tableView.reloadData()
            })
        }
        
        if selectedCity == "Fort Lauderdale" {
            ApiClient.fetchEvent(eventID:self.currentEvent.id, onCompletion:{ json in
                let pictureIDArray = json["data"]["event"]  ["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
                
                self.picArray = pictureIDArray
                
                //print("THIS IS THE PICTURE ARRAY FOR BOSTON \(self.picArray)")
                
                let comments = json["data"]["event"]["comments"]
                //print("here is the comment")
                
                //print(comments)
                guard let comments2 = json["data"]["event"]["comments"].array else {
                    return
                }
                //print("this is comments 2\(comments2)")
                
                self.currentEvent.comments = []

                for (_,val)in comments2.enumerated()  {
                    //print("this is val")
                    print(val)
                    
                    let user = User(fullName: val["user"]["full_name"].stringValue,
                                    profilePictureURL: val["user"]["profileImage"]["url"].stringValue)
                    let comment = Comment(text: val["text"].stringValue, user: user, karma: val["karma"].int!, timeStamp: "1 min ago",commentID:val["id"].int!)
                    
                    self.currentEvent.comments.append(comment)
                  
                    //print(comment.commentID)
                  
                    //print("here is the text")
                    
                }
                self.tableView.reloadData()
            })
        }
    }
    
    func refresh(sender:AnyObject) {
        print("refreshed")
        self.refresher?.beginRefreshing()
        self.fetchEvent()
        self.refresher?.endRefreshing()

        
    }
    
    func replyCommentData(comment: Comment) {
        self.replyComment = comment
        //print(self.replyComment.text)
        self.tableView.reloadData()
    }
    
    func loadTitle() {
       navTitle.title = "Event Details"
    }
    
    func retrievecommentData(comment:String) {
        if selectedCity == "Boston" {
            ApiClient.createComment(comment: comment, eventID: self.currentEvent.id, onCompletion:{ json in
                self.fetchEvent()
            })
        }
        if selectedCity == "Fort Lauderdale" {
            ApiClient.createComment(comment: comment, eventID: self.currentEvent.id, onCompletion:{ json in
                self.fetchEvent()
            })
        }
    }
    
//    func createPDF() {
//        if appDelegate.fortlauderdalePDFLinks.count < indexofEvent + 1 {
//            return
//        }
//        let remotePDFDocumentURLPath = "https://fortlauderdale.legistar.com/" + appDelegate.fortlauderdalePDFLinks[indexofEvent]
//        let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
//        let document = PDFDocument(url: remotePDFDocumentURL)!
//        let readerController = PDFViewController.createNew(with: document)
//        readerController.backgroundColor = .white
//        self.navigationController?.title = "Fort Lauderdale Agenda"
//        self.navigationController?.pushViewController(readerController, animated: true)
//    }
    
    func loadAgendaDetail(agenda: Agenda) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AgendaDetailViewController") as! AgendaDetailViewController
        
        controller.agenda = agenda
        controller.selectedCity = selectedCity
        controller.agendaImage = currentEvent.image
        self.present(controller, animated:true, completion: nil )
    }
    
    func attendbuttonTapped() {
        self.fetchEvent()
        self.tableView.reloadData()
    }
    
    func removeComment(comment:Comment) {
        if comment.user.fullName == self.appDelegate.user.fullName {
            let alert = UIAlertController(title: "You are about to delete your comment", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                if self.selectedCity == "Boston" {
                    ApiClient.deleteComment(commentID: comment.commentID,onCompletion:{ json in
                        self.fetchEvent()
                        self.tableView.reloadData()
            
                    })
                }
            
                if self.selectedCity == "Fort Lauderdale" {
                    ApiClient.deleteComment(commentID: comment.commentID,onCompletion:{ json in
                        self.fetchEvent()
                        self.tableView.reloadData()
                    })
                }
            }))
        
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                //print("Handle Cancel Logic here")
            
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func comparelauderdaleTime() -> Bool {
        if selectedCity == "Boston" {
            return false
        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let newDate = dateFormatter.string(from: date)
        let x = newDate == fortlauderdaleDataList[indexofEvent].date
        self.configureHour()
        
        let y = currentHour >=  fortlauderdaleDataList[indexofEvent].time
        //print(currentHour)
        //print(y)
        
        if x && y  {
            //print("times are compatible")
            return true
        } else {
            //print("times not compatible")
            return false
        }
    }
    
    func configureHour() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let hourString = String(hour)
        currentHour = hourString
    }
    
    func refreshTap(tapped:Bool) {
        streamPressed = tapped
        
        //print("event stream callback")
        //tableView.reloadData()
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "You are about to flag a comment as inappropriate", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            //print("Handle Ok logic here")
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            //print("Handle Cancel Logic here")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
   
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        //print("numberofSections")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberofRows")
    
        return 6 + currentEvent.comments.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var x = getDataList()
        if x[indexofEvent].comments.count == 0 {
            switch indexPath.row {
            case 0:
                if comparelauderdaleTime() == true {
                    return 500
                }
                return 145
            case 1:
                return 150
            case 2:
                return 176
            case 3:
                return 0
            case 4:
                return 52
            case 5:
                return 46
            default:
                return 46
            }
        }
        else {
            switch indexPath.row {
            case 0:
            return 200
            case 1:
            return 150
            case 2:
            return 176
            case 3:
            return 0
            case 4:
            return 52
            case 5:
            if currentEvent.comments.count == 0 {
                return 94
            }
            let x = currentEvent.comments[0].text.characters.count
            let y = Double(x)
            
            if y > 80.0 {
                let z = (94 + y * 0.5)
                return CGFloat(z)
            }
            return 94
            default:
                if indexPath.row < 5 + currentEvent.comments.count {
                    var x = currentEvent.comments[indexPath.row - 5].text.characters.count
                    var y = Double(x)
                
                    if y > 80.0 {
                        var z = (94 + y * 0.5)
                        return CGFloat(z)
                    }
                }
                
                if indexPath.row == (5 + currentEvent.comments.count) {
                    return 94
                } else {
                    return 94
                }
        }
      }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.row)
        print("CREATING CELL WITH ROW: \(indexPath.row)")
        if (indexPath.row == 0) {
            let eventStream =  tableView.dequeueReusableCell(withIdentifier: "EventStream") as! EventStream
                eventStream.eventTitlelabel.text = currentEvent.title
                eventStream.background.layer.cornerRadius = 10
                eventStream.eventDescription.text = currentEvent.description
                eventStream.dataList = dataList
                eventStream.user = self.user
                eventStream.configureImage()
                eventStream.bostonDataList = bostonDataList
            
                eventStream.fortlauderdaleDataList = fortlauderdaleDataList
                eventStream.currentEvent = currentEvent
                eventStream.eventTitle = eventTitle
                eventStream.selectionStyle = .none
                eventStream.eventTimeNoFormat = eventTimeNoFormat
                eventStream.eventHours = eventHours
                eventStream.eventInfo = eventInfo
                eventStream.indexofEvent = indexofEvent
                eventStream.eventStreamCallback = self
                eventStream.selectedCity = selectedCity
            
                eventStream.configure()
                eventStream.streamContent()
                eventStream.checkStatus()

            
            if selectedCity == "Fort Lauderdale"  && self.comparelauderdaleTime() == true  {
                eventStream.eventImage.image = currentEvent.image
                agendaImage = eventStream.eventImage.image!
                let eventStream =  tableView.dequeueReusableCell(withIdentifier: "FortLauderdaleStream") as! FortLauderdaleStream
                eventStream.fortlauderdaleDataList = fortlauderdaleDataList
                eventStream.playVideo()
                return eventStream
            }
            
            if selectedCity == "Boston" {
                eventStream.eventImage.image = currentEvent.image
                agendaImage = eventStream.eventImage.image!
            
                if eventStream.firstpress == false  && eventStream.compareTime() == false || eventStream.checkStatus() == true && eventStream.compareTime() == false {
                    if noAlert == false && selectedCity == "Boston" {
                        let alert = UIAlertController(title: "Constant Stream Available", message: "Boston offers a 24/7 live stream", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Watch", style: .default, handler: { (action: UIAlertAction!) in
                            //print("Handle Ok logic here")
                            self.videoRequested = true
                            tableView.reloadData()
                        
                        }))
                
                        alert.addAction(UIAlertAction(title: "No Thanks", style: .cancel, handler: { (action: UIAlertAction!) in
                            //print("Handle Cancel Logic here")
                            self.videoRequested = false
                        
                        }))

                        self.present(alert, animated: true, completion: nil)
                        noAlert = true
                        //present UI alert
                
                
                        // timer for three seconds
                        // present new cell git
                    }
                }
            }
            
            if eventStream.compareTime() == true || videoRequested == true {
                //print(checkAlert())
                // only works when cell for row is refreshed 
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                eventLiveStream.selectedCity = selectedCity
                eventLiveStream.eventTitle = eventTitle
                //print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
                if eventStream.compareTime() {
                    eventLiveStream.switchTitleOn()
                } else {
                    eventLiveStream.switchTitleOff()
                }
                currentEventStream = eventLiveStream
                
                return eventLiveStream
            }

            return eventStream
        }
        
        if(indexPath.row == 1) {
            let infoCell =  tableView.dequeueReusableCell(withIdentifier: "EventInfo", for:indexPath) as! EventInfo
            infoCell.selectionStyle = .none
            infoCell.eventAddress.text = currentEvent.address
            infoCell.eventTime.text = currentEvent.date
            infoCell.eventHour.text = currentEvent.time
            infoCell.collectionView.reloadData()
            infoCell.configure(event: currentEvent)
            infoCell.eventInfoCallback = self
            return infoCell
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            print("BUILDING AGENDA!")
            
            agendaCell.configureCell(event: currentEvent)
            agendaCell.selectedCity = selectedCity
            agendaCell.eventAgendaCallback = self
            agendaCell.indexofEvent = indexofEvent
            return agendaCell
        }
        
        if (indexPath.row==3) {
        
            //cell.userCollection.reloadData()
            //cell.configure(event: currentEvent)
            return UITableViewCell()
        }
        
        if (indexPath.row == 4) {
            print("creating discussion header")
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionHeader", for: indexPath) as! DiscussionHeader
            cell.selectionStyle = .none
            return cell
        }
        
        
        if currentEvent.comments.count == 0 {
            if (indexPath.row==5) {
                print("ADDING CREATE COMMENT")
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateComment", for:indexPath) as! CreateComment
                cell.commentCallBack = self
              
                //  discussionCell.user = self.appDelegate.user
                //discussionCell.configure()
                //discussionCell.selectionStyle = .none
                return cell
            } else {
                print("ADDING ATTEND CELL")
                let cell = tableView.dequeueReusableCell(withIdentifier: "AttendCell") as! AttendCell
                cell.AttendCellCallBack = self
                return cell
            }
        } else {
            var x = getDataList()
            if indexPath.row == (5 + currentEvent.comments.count) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateComment") as! CreateComment
                cell.commentCallBack = self
                
                if replyComment != nil {
                    cell.replytoComment(comment: self.replyComment)
                    self.replyComment = nil
                }
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDiscussion") as! EventDiscussion
            //print("printing value \(indexPath.row - 5)")
            cell.configure(comment: x[indexofEvent].comments[indexPath.row - 5])
            cell.selectionStyle = .none
            cell.discussionCallBack = self
            return cell
        }
        
        print("CREATING ATTEND CELL")
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendCell") as! AttendCell
        cell.AttendCellCallBack = self
        return cell
        
        
       
    }
    
    func getState() -> String {
        switch selectedCity {
        case "Boston":
            return "MA"
        case "Fort Lauderdale":
            return "FL"
        default:
            return "NY"
        }
    }
    
    func getDataList() -> [Event] {
        switch selectedCity {
        case "Boston":
            return bostonDataList
        case "Fort Lauderdale":
            return fortlauderdaleDataList
        default:
            return bostonDataList
        }
    }
    
    func loadDirections() {
        let addressString = "\(currentEvent.address) \(selectedCity) \(getState())"
        let formattedAddress = addressString.replacingOccurrences(of: " ", with: "+")
        let url = "https://www.google.com/maps/dir/?api=1&destination=\(formattedAddress)"
        
        if let url = URL(string: url) {
            UIApplication.shared.openURL(url)
        } else {
            //print("INVALID URL STRING")
        }
    }
}
