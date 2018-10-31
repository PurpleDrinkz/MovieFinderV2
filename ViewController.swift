//
//  ViewController.swift
//  MovieFinderV2
//
//  Created by Alumno on 31/10/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //"Height for row at" es para la altura de la celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //Delegate para contar el numero de celdas/filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datos.resultadosPeliculas.count
    }
    
    //Data Source construye la vista de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "cellResultadoPelicula") as! CeldaPeliculaController
        
        celda.lblTitulo.text = Datos.resultadosPeliculas[indexPath.row].titulo
        
        celda.lblAño.text = "\(Datos.resultadosPeliculas[indexPath.row].año)"
        //Así se castea de int a string /\
        
        return celda
    }
    
    //Despues de poner estos dos se linkea dandole click al table view y arrastrando al view controller
    
    //Outlets
    @IBOutlet weak var txtBusqueda: UITextField!
    @IBOutlet weak var aiCagandoBusqueda: UIActivityIndicatorView!
    @IBOutlet weak var tvPeliculas: UITableView!
    
    
    //Actions
    @IBAction func doTapBuscarPelicula(_ sender: Any) {
        
        
    }
    
    //Aquí se manda llamar a la URL
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://www.omdbapi.com/?apikey=1d2750f9&s=godfather").responseJSON{
            response in
            
            Datos.resultadosPeliculas.removeAll()
            
            if let dictResponse = response.result.value as? NSDictionary {
                
                if let arrResultados = dictResponse.value(forKey: "Search") as? NSArray {
                    for resultado in arrResultados{
                        if let dictResultado = resultado as? NSDictionary{
                            let nuevoResultado = Pelicula(diccionario: dictResultado)
                            
                            Datos.resultadosPeliculas.append(nuevoResultado)
                        }
                        
                    }
                    self.tvPeliculas.reloadData()
                }
                
            }
            
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

