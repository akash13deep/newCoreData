//
//  Edit.swift
//  LabTest1Sam
//
//  Created by MacStudent on 2020-01-14.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Edit: UIViewController{
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var tuition: UITextField!
    @IBOutlet weak var date: UITextField!
    var studentDetails:[Student] = []
    var index = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("saman")
        fetchData()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
       // print(studentDetails[index])
        
        name.text = studentDetails[index].name
        age.text = String(studentDetails[index].age)
        tuition.text = String(studentDetails[index].tution)
        date.text = dateFormatter.string(from: studentDetails[index].date!)
        
        
    }
    @IBAction func save(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .short
               dateFormatter.timeStyle = .none
        
        updateRecord(stu: studentDetails[index], name: name.text!,age : Int32(age.text!)!, tuition : Double(tuition.text!)!, date : dateFormatter.date(from: date.text!)!)
        
        self.navigationController?.popToRootViewController(animated: true)
        
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
    func updateRecord(stu : Student, name:String, age:Int32, tuition:Double, date:Date){
         stu.name = name
         stu.age = age
         stu.tution = tuition
         stu.date = date
         saveContext()
    }
    
    func saveContext () {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

