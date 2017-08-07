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

class EventDetailViewController: SetGovTableViewController, EventAgendaCallback, EventStreamCallback, CommentCallBack, DiscussionCallBack{
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
    var fortlauderdaleIDS = [Int]()
    var bostonIDS = [Int]()
    var commentArray = [Comment]()
    var currentEvent: Event!
    weak var collectionView: UICollectionView!
    var picArray = [String]()
    var user: User!
    var replyComment: Comment!
    
    @IBOutlet var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.user = self.appDelegate.user

        super.viewDidLoad()
        print("EventDetailViewController")
        self.loadTitle()
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.currentEvent = dataList[indexofEvent]
        print("these are the boston ids")
        print(bostonIDS)
        print("these are the fort lauderdale ids \(fortlauderdaleIDS)")
        print(agendaInfo)
        print(indexofEvent)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchEvent()
        print("this is the length of the comment array")
        print(commentArray.count)
        
        tableView.reloadData()

    }
    
    
    func checkAlert() -> Bool {
        if videoRequested == true {
            return true
        }
        else {
            return false
            
        }
    }
    
    func fetchEvent() {

        if selectedCity == "Boston" {
            self.bostonIDS = self.bostonIDS.sorted() { $0 < $1 }

            ApiClient.fetchEvent(eventID:self.bostonIDS[indexofEvent] , onCompletion:{ json in
            
                print(self.bostonIDS[self.indexofEvent])
            
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
                    
                
                self.commentArray = []

                for (_,val)in comments2.enumerated()  {
                    print("this is val")
                    print(val)
                   
                    let user = User(fullName: val["user"]["full_name"].stringValue,profilePictureURL: val["user"]["profileImage"]["url"].stringValue,interestedStatus: false,attendingStatus: false)
                    let comment = Comment(text: val["text"].stringValue, user: user, karma: val["karma"].int!, timeStamp: "1 min ago",commentID:val["id"].int!)
                    
        
                    self.commentArray.append(comment)
                    
                    
                   
                    print("here is the text")
                    
                }
                
                self.tableView.reloadData()

            })
        }
        if selectedCity == "Fort Lauderdale" {
            self.fortlauderdaleIDS = self.fortlauderdaleIDS.sorted() { $0 < $1 }
            ApiClient.fetchEvent(eventID:self.fortlauderdaleIDS[indexofEvent] , onCompletion:{ json in 
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
                
                
                self.commentArray = []
                
                for (_,val)in comments2.enumerated()  {
                    print("this is val")
                    print(val)
                    
                    let user = User(fullName: val["user"]["full_name"].stringValue,profilePictureURL: val["user"]["profileImage"]["url"].stringValue,interestedStatus: false,attendingStatus: false)
                    let comment = Comment(text: val["text"].stringValue, user: user, karma: val["karma"].int!, timeStamp: "1 min ago",commentID:val["id"].int!)
                    
                  
                    self.commentArray.append(comment)
                  
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
            navTitle.title = arrayEvents[indexofEvent]
            eventTitle = navTitle.title!
        }
        
        if selectedCity == "Fort Lauderdale" {
            print("loading title")
            print(selectedEvents)
            print(eventList)
            print(indexofEvent)
    
            navTitle.title = fortlauderdaleArray[indexofEvent][0]
            print(fortlauderdaleArray)
            
            let z = fortlauderdaleArray[indexofEvent][0].components(separatedBy: " ")
            print(fortlauderdaleArray[indexofEvent][0])
            let finalDescription = z
            print(z.count)
            self.eventDescription = (finalDescription[finalDescription.count-1])

            
            eventTitle = navTitle.title!
       
        }
        
    }
    
    func retrievecommentData(comment:String) {
        print(comment)
        if selectedCity == "Boston" {
            ApiClient.createComment(comment: comment, eventID: self.bostonIDS[indexofEvent], onCompletion:{ json in
                self.fetchEvent()
                
            })
           
        }
        
        if selectedCity == "Fort Lauderdale" {
            ApiClient.createComment(comment: comment, eventID: self.fortlauderdaleIDS[indexofEvent], onCompletion:{ json in
                self.fetchEvent()
            })
            
        }
       
    }
    
    
    
    
    func loadAgendaDetail(data: Dictionary<Int,String>,infoData:[[String]],agendaTitles:[String],index:Int) {
        
        print("EVENT AGENDA CALLBACK")
        print("LOADING AGENDA DETAIL HERE")
        agendaInfo = data
        print(agendaInfo)
        Index = index
        paragraphArray = infoData
        agendaTitle = agendaTitles
        print(data)
        print(data)
        
        
        
    }
    
    
    
    func attendbuttonTapped() {
        print("attend button tapped, callback now")
        self.fetchEvent()
        self.tableView.reloadData()
        
    }
    
    func removeComment(comment:Comment) {
        
        if selectedCity == "Boston" {
            ApiClient.deleteComment(comment: comment.text, eventID: self.bostonIDS[indexofEvent], onCompletion:{ json in
                
                self.fetchEvent()
                self.tableView.reloadData()
                
            })
            
        }
        
        if selectedCity == "Fort Lauderdale" {
            ApiClient.deleteComment(comment: comment.text, eventID: self.fortlauderdaleIDS[indexofEvent], onCompletion:{ json in
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
    
    func loadVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AgendaDetailViewController") as! AgendaDetailViewController
        controller.agendaImage = agendaImage
        controller.eventTitle = eventTitle
        controller.paragraphArray = paragraphArray
        controller.agendaInfo = agendaInfo
        controller.index = Index
        controller.agendaTitles = agendaTitle
        controller.selectedCity = selectedCity 
        self.present(controller, animated:true, completion: nil )
    
   
    
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
       // return 4 + commentArray.count + 1
        if commentArray.count == 0 {
            return 6
        }
        return 6 + commentArray.count
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if commentArray.count == 0 {
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
            if indexPath.row == (5 + commentArray.count)    {
                
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
                eventStream.bostonIDS = bostonIDS
    
                eventStream.fortlauderdaleIDS = fortlauderdaleIDS
                print(fortlauderdaleIDS)
                print(eventStream.fortlauderdaleIDS)
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
                eventStream.fortlauderdaleIDS = fortlauderdaleIDS

                eventStream.eventImage.image = eventImages[indexofEvent]
                agendaImage = eventStream.eventImage.image!
            
            
        if selectedCity == "Boston" {
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
            
            
            
            if eventStream.compareTime() == true && eventStream.firstpress == false || videoRequested == true {
                print(checkAlert())
                // only works when cell for row is refreshed 
                
                let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    eventStream.nowLive()
                }

                
            if eventStream.compareTime() == true {
                
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                eventLiveStream.selectedCity = selectedCity
                eventLiveStream.switchTitleOn()
                print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
                eventLiveStream.switchTitleOn()
                print("Times are the same")
                
                return eventLiveStream
                
            }
                
            if eventStream.compareTime() == false {
                
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                eventLiveStream.selectedCity = selectedCity
                eventLiveStream.switchTitleOn()
                print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
                eventLiveStream.switchTitleOff()
                return eventLiveStream
                
            }

                                        //present event stream
                
            

            }
          
          
            if eventStream.initiateStream == true {
                // add transition with 2 second delay coming in from the right 
                print(eventStream.presentStream)
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
               
                return eventLiveStream

            }
            print("cell for row" )

            
            return eventStream
            
            
            
        }
        
        if(indexPath.row == 1) {
            let infoCell =  tableView.dequeueReusableCell(withIdentifier: "EventInfo", for:indexPath) as! EventInfo
            infoCell.selectionStyle = .none
            print(eventInfo)
            print("stop")
            print(indexofEvent)
            
           
            print(selectedCity)
            if selectedCity == "Boston" {
                print(indexofEvent)
                
                infoCell.eventAddress.text = EventAddresses[indexofEvent]
                print(eventTimeNoFormat)
            
                infoCell.eventTime.text = eventTimeNoFormat[indexofEvent]
                infoCell.eventHour.text = eventHours[indexofEvent][1]
            
                return infoCell
            }
            
            if selectedCity == "Fort Lauderdale" {
                print(fortlauderdaleArray)

                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yy"
                formatter.dateStyle = .short
                if let date = formatter.date(from: fortlauderdaleArray[indexofEvent][1]){
                    let y = formatter.string(from: date)
                    infoCell.eventTime.text = String(describing: y)
                }
                infoCell.eventAddress.text = "100 North Andrews Avenue"
                let z = fortlauderdaleArray[indexofEvent][6].trimmingCharacters(in: .whitespacesAndNewlines)
                print(z)
                print(fortlauderdaleArray[indexofEvent])
                
                infoCell.eventHour.text = z
                
                
                return infoCell
                
                
            }
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            agendaCell.selectionStyle = .none
            agendaCell.eventDescription = eventDescription
            agendaCell.descriptionArray = descriptionArray
            agendaCell.agendaInfo = agendaInfo
            agendaCell.selectedCity = selectedCity
            print(agendaInfo)
            agendaCell.index = Index
            agendaCell.eventAgendaCallback = self
            agendaCell.indexofEvent = indexofEvent
            agendaCell.hrefArray = hrefArray
            print("HELLO")
            
            return agendaCell
        }
        
        if (indexPath.row==3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventMembers", for:indexPath) as! EventMembers
            print(bostonIDS)
            cell.selectionStyle = .none
            print("picture array from event detail")
            print(picArray)
            cell.picArray = picArray
            collectionView = cell.userCollection
            cell.userCollection.reloadData()
            print(cell.picArray)
            
            cell.fortlauderdaleIDS = fortlauderdaleIDS
            return cell
        }
        
        if (indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionHeader", for: indexPath) as! DiscussionHeader
            cell.selectionStyle = .none
            return cell
        }
        if commentArray.count == 0 {
        
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
            
            if indexPath.row == (5 + commentArray.count) {
                print(commentArray[0].text)
                
               let cell = tableView.dequeueReusableCell(withIdentifier: "CreateComment") as! CreateComment
                cell.commentCallBack = self
                
                if replyComment != nil {
                    
                    cell.replytoComment(comment: self.replyComment)
                    self.replyComment = nil
                }
                return cell
            }
            
            print(commentArray.count)
            
            
       
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventDiscussion") as! EventDiscussion
                print("printing value \(indexPath.row - 5)")
                print(commentArray[indexPath.row - 5].text)
           
                cell.configure(comment: commentArray[indexPath.row - 5])
                cell.selectionStyle = .none
                cell.discussionCallBack = self 
                return cell
                
            
        
        }
       
            
            
        
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "EventStream", for:indexPath) as! EventStream
        return cell
        
    
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
        
    
        
        
        
        
    }

  
    }

