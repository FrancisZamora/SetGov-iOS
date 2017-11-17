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

class EventDetailViewController: SetGovTableViewController, EventAgendaCallback, EventInfoCallback, EventStreamCallback, CommentCallBack, DiscussionCallBack, AttendCellCallBack, UIDocumentInteractionControllerDelegate {
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
    
    var commentsToShow = [Comment]()

    @IBOutlet var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.user = self.appDelegate.user
        refresher = UIRefreshControl()
        
        super.viewDidLoad()
        
        print("LOADED WITH EVENT LINK: \(currentEvent.agendaLink)")
        
        addButton()
        
        self.loadTitle()
        
        self.refresher?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set("off", forKey: eventTitle)
    }
    
    func addButton() {
        let button = UIButton(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: view.frame.width, height: 200))
        self.view.addSubview(button)
    }
    
    func attendbuttonTapped() {
        self.fetchEvent()
        self.tableView.reloadData()
    }
    
    func checkAlert() -> Bool {
        if videoRequested == true {
            return true
        }
        else {
            return false
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
    
    func fetchEvent() {
        ApiClient.fetchEvent(eventID:self.currentEvent.id)
            .then { event -> Void  in
                self.currentEvent = event
                
                self.commentsToShow = [Comment]()
                self.currentEvent.comments.forEach({ (c) in
                    self.commentsToShow.append(c)
                    c.replies.forEach({ (rc) in
                        rc.isReply = true
                        self.commentsToShow.append(rc)
                    })
                })
                
                self.tableView.reloadData()
            }.catch { error in
                print("Error fetchEvent:\(error.localizedDescription)")
        }
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
    
    func loadTitle() {
        navTitle.title = "Event Details"
    }
    
    func loadAgendaDetail() {
        
        print("LOAD PDF VIEWER HERE: \(currentEvent.agendaLink)")
        if let url = URL(string: currentEvent.agendaLink) {
            print("got url")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("no url")
        }
    }
    
    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        print("will begin sending")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        //print("numberofSections")
        return 1
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
    
    func retrievecommentData(comment: String, replyCommentId: Int?) {
        if replyCommentId != nil {
            ApiClient.createReply(comment: comment, eventId: self.currentEvent.id, replyCommentId: replyCommentId!)
                .then { json in
                    self.fetchEvent()
                }
        } else {
            ApiClient.createComment(comment: comment, eventID: self.currentEvent.id, onCompletion:{ json in
                self.fetchEvent()
            })
        }
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
    
    func refreshTap(tapped:Bool) {
        streamPressed = tapped
        
        //print("event stream callback")
        //tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var replies = 0
//        currentEvent.comments.forEach { (c) in
//            replies = replies + c.replies.count
//        }
//        return 6 + currentEvent.comments.count + replies

        return 6 + commentsToShow.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var x = getDataList()
        if commentsToShow.count == 0 {
        switch indexPath.row {
            case 0:
                if comparelauderdaleTime() == true {
                    return 500
                }
                return 145
            case 1:
                return 150
            case 2:
                return 160
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
            return 160
            case 3:
            return 0
            case 4:
            return 52
            case 5:
            if commentsToShow.count == 0 {
                return 94
            }
            let x = commentsToShow[0].text.characters.count
            let y = Double(x)
            
            if y > 80.0 {
                let z = (94 + y * 0.5)
                return CGFloat(z)
            }
            return 94
            default:
                if indexPath.row < 5 + commentsToShow.count {
                    var x = commentsToShow[indexPath.row - 5].text.characters.count
                    var y = Double(x)
                
                    if y > 80.0 {
                        var z = (94 + y * 0.5)
                        return CGFloat(z)
                    }
                }
                
                if indexPath.row == (5 + commentsToShow.count) {
                    return 94
                } else {
                    return 94
                }
        }
      }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.row)
        print("cellForRowAt: \(indexPath.row)")
        if (indexPath.row == 0) {
            let eventStream =  tableView.dequeueReusableCell(withIdentifier: "EventStream") as! EventStream
            
            eventStream.eventTitlelabel.text = currentEvent.name
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
            
            
            print("USING EVENT DATE: \(currentEvent.date)")

            infoCell.configure(event: currentEvent)
            infoCell.eventInfoCallback = self
            return infoCell
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            print("BUILDING AGENDA!: \(currentEvent)")
            
            
            
            agendaCell.configureCell(event: currentEvent)
            agendaCell.selectedCity = selectedCity
            agendaCell.eventAgendaCallback = self
            agendaCell.indexofEvent = indexofEvent
            return agendaCell
        }
        
        if (indexPath.row == 3) {
        
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
        
        
        if commentsToShow.count == 0 {
            if (indexPath.row == 5) {
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
            if indexPath.row == (5 + commentsToShow.count) {
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
            print("self.appDelegate.user \(self.appDelegate.user.userId)")
            cell.user = self.appDelegate.user
            cell.configure(comment: commentsToShow[indexPath.row - 5])
            cell.selectionStyle = .none
            cell.discussionCallBack = self
            return cell
        }
        
        print("CREATING ATTEND CELL")
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendCell") as! AttendCell
        cell.AttendCellCallBack = self
        return cell
        
        
       
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
    //        self.navigationController?.name = "Fort Lauderdale Agenda"
    //        self.navigationController?.pushViewController(readerController, animated: true)
    //    }
    
}
