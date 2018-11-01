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
    
    //Se crea una variable de URL base para poder buscar con el text field
    let urlBase = "https://www.omdbapi.com/?apikey=1d2750f9&s="
    
    //Actions
    @IBAction func doTapBuscarPelicula(_ sender: Any) {
        //Aquí hasta presionar el botón buscar, se hace la llamada a alamo fire
        aiCagandoBusqueda.startAnimating()
        
        //Variable que me dice que esta buscando el ususario
        var busqueda = txtBusqueda.text!
        
        busqueda = busqueda.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        Alamofire.request("\(urlBase)\(busqueda)").responseJSON{
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
            self.aiCagandoBusqueda.stopAnimating()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? DetallePeliculaController{
            destino.pelicula = Datos.resultadosPeliculas[(tvPeliculas.indexPathForSelectedRow?.row)!]
        }
    }
    
    //Aquí se manda llamar a la URL
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

