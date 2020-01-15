//
//  Book.swift
//  LabTest1Sam
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Details: UIViewController{
   
    var worksOK = ""
    
    //label outlets
//
//    @IBOutlet weak var label1: UILabel!
//    @IBOutlet weak var label2: UILabel!
//    @IBOutlet weak var label3: UILabel!
//    @IBOutlet weak var label4: UILabel!
//
    //TextFileds outlet
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var tutionText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
   // context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var student:[NSManagedObjectContext] = []
     var managedContext: NSManagedObjectContext!
   
    override func viewDidLoad()
    {
    super.viewDidLoad()
        print(worksOK)
    }
    
    @IBAction func saveBtn(_ sender: Any)
    {
        
      //  save()
        
               let nameToSave = nameText.text
               let ageToSave = ageText.text
               let tuitionToSave = tutionText.text
               let dateToSave = dateText.text
               
               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .short
               dateFormatter.timeStyle = .none
//        if nameToSave==nil||ageToSave==nil||tuitionToSave==nil||dateToSave==nil
//        {
//            print("hi")
//
//        }else
//        {
        self.save(name: nameToSave!,age : Int32(ageToSave!)!, tuition : Double(tuitionToSave!)!, date : dateFormatter.date(from: dateToSave!)!)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }

    }
    
   func save(name: String, age : Int32, tuition : Double, date : Date)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
    let students = NSManagedObject(entity: entity,insertInto: managedContext)

        
    students.setValue(age, forKey: "age")
    students.setValue(date, forKey: "date")
    students.setValue(name, forKey: "name")
    students.setValue(tuition, forKey: "tution")
        
        
        do {
                try managedContext.save()
    
            }
            catch let error as NSError {
                print(error)
            }
    }
    
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if(segue.identifier == "ViewController"){
//           let displayVC = segue.destination as! Book
//           displayVC.delegate = self
//       }
//   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController
        {
           
            let vc = segue.destination as? ViewController
           
           }
           }
      }

