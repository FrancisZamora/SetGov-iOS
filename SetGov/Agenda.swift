//
//  Agenda.swift
//  SetGov
//
//  Created by Balin on 8/9/17.
//  Copyright © 2017 Francis. All rights reserved.
//


import Foundation

class Agenda {
    
    var agendaItemName: String  = ""
    var agendaItemDescription: String = ""
    //var type: String = ""
    
    init(name: String, description: String) {
        self.agendaItemName = name
        self.agendaItemDescription = description
    }

}

