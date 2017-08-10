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
    //var type: String = ""
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    static func buildGraphString(agendaList: [Agenda]) -> String {
        
        var graphString = "["
        
        for agenda in agendaList {
            graphString.append("{agendaItemName: \"\(agenda.name)\", agendaItemDescription: \"\(agenda.description)\"},")
        }
        graphString.remove(at: graphString.index(before: graphString.endIndex))
        graphString.append("]")
        
        print("BUILT GRAPH STRING: \(graphString)")
        
        return graphString
    }

}

