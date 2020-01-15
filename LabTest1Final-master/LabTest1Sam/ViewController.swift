//
//  ViewController.swift
//  LabTest1Sam
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController{
    //outlet for tableview
    @IBOutlet weak var tableView: UITableView!
    weak var delegate : ViewController?
    var index: Int = 0
    
   //next bar button item
    @IBAction func nextBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Book") as? Details
        vc!.worksOK = "dfhdfgjsgf"
       
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //array of book names
   var studentDetails:[Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //title student dia details
        //title = "Students Details"
        //register karna table nu te cell nu register class de nal
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    func fetchData(){
       
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do{
            studentDetails = try context.fetch(Student.fetchRequest())
        }
            //if error exists/catch it
        catch{
            print(error)
        }
    }
   
}


// extend wala controller
extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    //dasda kinia rows ne ik particular section ch
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        //cell.textLabel?.text = studentDetails[indexPath.row]
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .short
           dateFormatter.timeStyle = .none
        
        let value = studentDetails[indexPath.row]
        //cell.textLabel!.text = value.name! + ", " + String(value.tution) + ", " + String(value.age) + ", " + dateFormatter.string(from: value.date!)
        
        cell.label1.text = "Name:  "+value.name!
        cell.label2.text = "Age:  "+String(value.tution)
        cell.label3.text = "Tuition Fees:  "+String(value.age)
        cell.label4.text = "Term Start Date:  "+dateFormatter.string(from: value.date!)

        return cell
    }
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let person = studentDetails[indexPath.row]
            context.delete(person)

                do {
                        try context.save()

                    }
                    catch let error as NSError {
                        print(error)
                    }

            fetchData()
            tableView.reloadData()
        }

       
               }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        

        if let viewController = storyboard?.instantiateViewController(identifier: "Edit") as? Edit {
            viewController.index =  indexPath.row
           //   viewController.
            navigationController?.pushViewController(viewController, animated: true)
            //print("hello")
        }
    }
}
    
