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
import Alamofire
import AlamofireImage


class Pelicula {
    
    var titulo : String
    var año : Int
    var id : String?
    var clasificacion : String?
    var genero: String?
    var director : String?
    var duracion : String?
    var posterPelicula :String?
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
        
        if let valorAño = diccionario.value(forKey: "Year") as? String{
            
            //Este codigo toma los primeros cuatro caracteres de un string mediante indexes
            let indiceFinal = valorAño.index(valorAño.startIndex, offsetBy: 4)
            año = Int(valorAño[..<indiceFinal])!
        }
        
        //Se agrega la propiedad de la ID porque es más espeficico al momento de buscar
        if let imdbID = diccionario.value(forKey: "imdbID") as? String {
            self.id = imdbID
        }
        
        
    }
    
}
