//
//  Pelicula.swift
//  MovieFinderV2
//
//  Created by Alumno on 31/10/18.
//  Copyright © 2018 Alumno. All rights reserved.
//


//Aquí se definen los atributos que tendría cada modelo a traves de variables
import Foundation
import UIKit

class Pelicula {
    
    var titulo : String
    var año : Int
    var clasificacion : String?
    var genero: String?
    var director : String?
    //Las ultimas variables son opcionales para usarlas posteriormente
    
    
    
    //Se inicializan las variables
    init (titulo : String, año : Int){
        
        self.titulo = titulo
        self.año = año
        
    }
    
    
    init (diccionario : NSDictionary) {
        titulo = ""
        año = 0
        
        if let valorTitulo = diccionario.value(forKey: "Title") as? String{
            titulo = valorTitulo
            
        }
        
        if let valorAño = diccionario.value(forKey: "Year") as? Int{
            
            año = valorAño
        }
    }
}
