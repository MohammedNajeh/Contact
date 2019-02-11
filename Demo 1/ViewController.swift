//
//  ViewController.swift
//  Demo 1
//
//  Created by mohamed on 1/29/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate=self
        tableview.dataSource=self
        contactStore.requestAccess(for: .contacts){ (success , error) in
            if success{
            print("Sucessful")
            
            }
        }
        FetchContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
         let contactToDisplay = contacts[indexPath.row]
         cell.textLabel?.text=contactToDisplay.givenName+"  "+contactToDisplay.familyName
         cell.detailTextLabel?.text = contactToDisplay.phoneNumber
         return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func FetchContacts() {
        let Key = [CNContactGivenNameKey , CNContactFamilyNameKey , CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: Key)
        
        try! contactStore.enumerateContacts(with: request){(contact ,stoppingPointer) in
            
            let name = contact.givenName
            let family = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = ContactStruct(givenName: name, familyName: family, phoneNumber: number!)
            self.contacts.append(contactToAppend)
            
        }
        tableview.reloadData()
    }

}

