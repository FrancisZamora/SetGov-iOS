//
//  Agenda.swift
//  SetGov
//
//  Created by Balin on 8/9/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation

class Agenda {
    
    var name: String  = ""
    var description: String = ""
    var text: String = ""
    //var type: String = ""
    
    init(name: String, description: String, text: String) {
        self.name = name
        self.description = description
        self.text = text
    }
    
    init() {
        
    }
    
    static func buildGraphString(agendaList: [Agenda]) -> String {
        var graphString = "["
        
        for agenda in agendaList {
            agenda.text = agenda.text.replacingOccurrences(of: "\n", with: "%^&*")
            agenda.text = agenda.text.replacingOccurrences(of: "\"", with: "")
            graphString.append("{agendaItemName: \"\(agenda.name)\", agendaItemDescription: \"\(agenda.description)\", agendaItemText: \"\(agenda.text)\", agendaItemType: \"type\"},")
        }
        graphString.remove(at: graphString.index(before: graphString.endIndex))
        graphString.append("]")
        
        print("BUILT GRAPH STRING: \(graphString)")
        
        return graphString
    }

}
