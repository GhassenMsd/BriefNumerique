//
//  Affaire.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 11/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Affaire: NSObject {
    
    var nameAff = ""
    var numAff = ""
    var degre = ""
    var sujet = ""
    var date: Date?
    var etat = ""
    var idClt = 0
    var idCrl = 0
    var numCasPrec = ""
    var numAvCont = ""
    var etatAvCont = 0
    
    init(nameAff: String, numAff: String, degre: String, sujet: String,date: Date, etat: String, idClt: Int, idCrl: Int, numCasPrec: String, numAvCont: String, etatAvCont: Int){
        self.numAff = numAff ;
        self.nameAff = nameAff;
        self.degre = degre;
        self.sujet = sujet;
        self.date = date;
        self.etat = etat;
        self.idClt = idClt;
        self.idCrl = idCrl;
        self.numCasPrec = numCasPrec;
        self.numAvCont = numAvCont;
        self.etatAvCont = etatAvCont;
    }
}