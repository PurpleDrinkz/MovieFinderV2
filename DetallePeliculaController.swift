//
//  DetallePeliculaController.swift
//  MovieFinderV2
//
//  Created by Alumno on 01/11/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class DetallePeliculaController : UIViewController{
    
    var pelicula : Pelicula?
    let urlBase = "https://www.omdbapi.com/?apikey=1d2750f9&i="

    
    
    //OUTLETS
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAño: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblClasificacion: UILabel!
    @IBOutlet weak var lblDuracion: UILabel!
    
    
    //ACTIONS
    @IBAction func doTapAtras(_ sender: Any) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pelicula != nil {
            lblTitulo.text = pelicula?.titulo
            lblAño.text = "\(pelicula!.año)"
            //Y así para los que faltan(Genero, direcor, duracion)
        }
        
        //AQUI SE HACE EL LLAMADO ALAMO FIRE PARA SACAR LA INFORMACION DEL DETALLE DE LAS PELICULAS
        if pelicula != nil {
            Alamofire.request("\(urlBase)\(pelicula!.id!)").responseJSON{
                response in
                if let dictResultado = response.result.value as? NSDictionary{
                    
                    if let clasificacion = dictResultado.value(forKey: "Rated") as? String{
                        self.pelicula?.clasificacion = clasificacion
                        self.lblClasificacion.text = clasificacion
                    }
                    //Y así para los que faltan (Genero, director, duracion)
                    if let director = dictResultado.value(forKey: "Director") as? String{
                        self.pelicula?.director = director
                        self.lblDirector.text = director
                    }
                    
                    if let genero = dictResultado.value(forKey: "Genre") as? String{
                        self.pelicula?.genero = genero
                        self.lblGenero.text = genero
                    }
                    
                    if let duracion = dictResultado.value(forKey: "Runtime") as? String{
                        self.pelicula?.genero = duracion
                        self.lblGenero.text = duracion
                    }
                    
                }
            }
        }
        
    }
    
}
