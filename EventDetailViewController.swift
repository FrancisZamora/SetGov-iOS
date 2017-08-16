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

class EventDetailViewController: SetGovTableViewController, EventAgendaCallback, EventInfoCallback, EventStreamCallback, CommentCallBack, DiscussionCallBack{
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
    var user: User!
    var replyComment: Comment!
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    var userArray = [User]()
    var currentEventStream: EventLiveStream?

    
    @IBOutlet var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.user = self.appDelegate.user

        super.viewDidLoad()
        print("EventDetailViewController")
        self.loadTitle()
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        print(agendaInfo)
        print(indexofEvent)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // self.fetchEvent()
        print("CURRENT AGENDA: \(currentEvent.agendaItems)")
        print("this is the length of the comment array")
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let stream = currentEventStream {
            //stream.timer.invalidate()
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

            ApiClient.fetchEvent(eventID:self.bostonDataList[indexofEvent].id , onCompletion:{ json in
                self.userArray = []
                let attendees = json["data"]["event"]["attendingUsers"].array
                for users in attendees! {
                    if let fullName = users["full_name"].string,
                        let profileURL = users["profileImage"]["url"].string {
                        self.userArray.append(User(fullName: fullName, profilePictureURL: profileURL))
                    }
                }
                
                self.currentEvent.users = self.userArray
                print(self.currentEvent.users)
                
                print("THIS IS THE PICTURE ARRAY FOR BOSTON \(self.picArray)")
                
          
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
                    
                    
                   
                    print("here is the text")
                    
                }
                
                self.tableView.reloadData()

            })
        }
        if selectedCity == "Fort Lauderdale" {
            ApiClient.fetchEvent(eventID:self.fortlauderdaleDataList[indexofEvent].id , onCompletion:{ json in
                let pictureIDArray = json["data"]["event"]  ["attendingUsers"].arrayValue.map({$0["profileImage"]["url"].stringValue})
                
                self.picArray = pictureIDArray
                
                print("THIS IS THE PICTURE ARRAY FOR BOSTON \(self.picArray)")
                
                let comments = json["data"]["event"]["comments"]
                print("here is the comment")
                
                print(comments)
                guard let comments2 = json["data"]["event"]["comments"].array else {
                    return
                }
                print("this is comments 2\(comments2)")
                
                
                
                for (_,val)in comments2.enumerated()  {
                    print("this is val")
                    print(val)
                    
                    let user = User(fullName: val["user"]["full_name"].stringValue,
                                    profilePictureURL: val["user"]["profileImage"]["url"].stringValue)
                    let comment = Comment(text: val["text"].stringValue, user: user, karma: val["karma"].int!, timeStamp: "1 min ago",commentID:val["id"].int!)
                    
                    self.currentEvent.comments.append(comment)
                  
                    print(comment.commentID)
                  
                    print("here is the text")
                    
                }
                self.tableView.reloadData()
            })
        }
    }
    
    func refresh(sender:AnyObject) {
        print("refreshed")
        self.refreshControl?.beginRefreshing()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.refreshControl?.endRefreshing()
            print("stop refreshing")
        }
    }
    
    func replyCommentData(comment: Comment) {
        self.replyComment = comment
        print(self.replyComment.text)
        self.tableView.reloadData()
    }
    
    func loadTitle() {
        if selectedCity == "Boston" {
            print("loading title")
            print(selectedEvents)
            print(eventList)
            print(indexofEvent)
            navTitle.title = bostonDataList[indexofEvent].title
            eventTitle = navTitle.title!
        }
        
        if selectedCity == "Fort Lauderdale" {
            print("loading title")
            print(selectedEvents)
            print(eventList)
            print(indexofEvent)
    
            navTitle.title = fortlauderdaleDataList[indexofEvent].title
            print(fortlauderdaleArray)
            
            self.eventDescription = currentEvent.description

            eventTitle = navTitle.title!
        }
    }
    
    func retrievecommentData(comment:String) {
        print(comment)
        if selectedCity == "Boston" {
            ApiClient.createComment(comment: comment, eventID: self.bostonDataList[indexofEvent].id, onCompletion:{ json in
                self.fetchEvent()
            })
           
        }
        
        if selectedCity == "Fort Lauderdale" {
            ApiClient.createComment(comment: comment, eventID: self.fortlauderdaleDataList[indexofEvent].id, onCompletion:{ json in
                self.fetchEvent()
            })
        }
    }
    
    func loadAgendaDetail(agenda: Agenda) {
        
        print("EVENT AGENDA CALLBACK")
        print("LOADING AGENDA DETAIL HERE")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AgendaDetailViewController") as! AgendaDetailViewController
        
        controller.agenda = agenda
        controller.selectedCity = selectedCity
        controller.agendaImage = currentEvent.image
        self.present(controller, animated:true, completion: nil )
    }
    
    
    func attendbuttonTapped() {
        print("attend button tapped, callback now")
        self.fetchEvent()
        self.tableView.reloadData()
        
    }
    
    func removeComment(comment:Comment) {
        
        if selectedCity == "Boston" {
            ApiClient.deleteComment(commentID: comment.commentID,onCompletion:{ json in
                self.fetchEvent()
                self.tableView.reloadData()
                
            })
            
        }
        
        if selectedCity == "Fort Lauderdale" {
            ApiClient.deleteComment(commentID: comment.commentID,onCompletion:{ json in
                self.fetchEvent()
                self.tableView.reloadData()
            })
            
        }

        
    }
    
    func refreshTap(tapped:Bool) {
        streamPressed = tapped
        
        print("event stream callback")
        //tableView.reloadData()
        
        
    }
   
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        print("numberofSections")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofRows")
    
        return 6 + currentEvent.comments.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var x = getDataList()
        if x[indexofEvent].comments.count == 0 {
            switch indexPath.row {
            case 0:
                return 200
            case 1:
                return 38
            case 2:
                return 176
            case 3:
                return 94
            case 4:
                return 46
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
            return 38
            case 2:
            return 176
            case 3:
            return 94
            case 4:
            return 46
            case 5:
            return 94
            default:
            if indexPath.row == (5 + x[indexofEvent].comments.count)    {
                
                return 46
            }
            else {
                return 94
            }
                
        }
      }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        if (indexPath.row == 0) {
            let eventStream =  tableView.dequeueReusableCell(withIdentifier: "EventStream") as! EventStream
            
            
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
            
            if selectedCity == "Fort Lauderdale" {
                eventStream.eventImage.image = currentEvent.image
                agendaImage = eventStream.eventImage.image!
            }
            
        if selectedCity == "Boston" {
            eventStream.eventImage.image = currentEvent.image
            agendaImage = eventStream.eventImage.image!
            
            if eventStream.firstpress == false  && eventStream.compareTime() == false || eventStream.checkStatus() == true && eventStream.compareTime() == false {
                if noAlert == false && selectedCity == "Boston" {
                    let alert = UIAlertController(title: "Constant Stream Available", message: "Boston offers a 24/7 live stream", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Watch", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    self.videoRequested = true
                    tableView.reloadData()
                        
                }))
                
                    alert.addAction(UIAlertAction(title: "No Thanks", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
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
                print(checkAlert())
                // only works when cell for row is refreshed 
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                eventLiveStream.selectedCity = selectedCity
                eventLiveStream.eventTitle = eventTitle
                print ("returning stream")
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
            infoCell.eventInfoCallback = self
            return infoCell
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            agendaCell.configureCell(event: currentEvent)
            agendaCell.selectedCity = selectedCity
            agendaCell.eventAgendaCallback = self
            return agendaCell
        }
        
        if (indexPath.row==3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventMembers", for:indexPath) as! EventMembers
            cell.userCollection.reloadData()
            cell.configure(event: currentEvent)

            return cell
        }
        
        if (indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionHeader", for: indexPath) as! DiscussionHeader
            cell.selectionStyle = .none
            return cell
        }
        var x = getDataList()
        if currentEvent.comments.count == 0 {
        
            if (indexPath.row==5) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateComment", for:indexPath) as! CreateComment
                cell.commentCallBack = self
              
                //  discussionCell.user = self.appDelegate.user
                //discussionCell.configure()
                //discussionCell.selectionStyle = .none
                return cell
            }
        }
        else {
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
                print("printing value \(indexPath.row - 5)")
                cell.configure(comment: x[indexofEvent].comments[indexPath.row - 5])
                cell.selectionStyle = .none
                cell.discussionCallBack = self 
                return cell
                
            
        
        }
        let cell =  tableView.dequeueReusableCell(withIdentifier: "EventStream", for:indexPath) as! EventStream
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
            print("INVALID URL STRING")
        }
    }
}

