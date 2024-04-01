//
//  CollectionsTableViewController.swift
//  ColorLoversApp
//

import UIKit
import CoreData

class CollectionsTableViewController: UITableViewController {

    var savedColors: [String] = []
    var currentColor: [String] = []
    var palettes: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPalettes()
        correctData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func fetchPalettes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Palette")

        do {
            let palettes = try context.fetch(fetchRequest)
            for palette in palettes {
                if let colors = palette.value(forKey: "palettes") as? [String] {
                    savedColors = colors
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func correctData() {
        for i in 0..<savedColors.count/11 {
            currentColor = Array(savedColors[(i*11)...((i*11)+10)])
            palettes.append(currentColor)
        }
        print(palettes)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedColors.count/11
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionsTableViewCell
        cell.colorLabel1.text = "#" + palettes[indexPath.row][0]
        cell.colorLabel2.text = "#" + palettes[indexPath.row][2]
        cell.colorLabel3.text = "#" + palettes[indexPath.row][4]
        cell.colorLabel4.text = "#" + palettes[indexPath.row][6]
        cell.colorLabel5.text = "#" + palettes[indexPath.row][8]

        cell.colorLabel1.backgroundColor = UIColor(hex: palettes[indexPath.row][0])
        cell.colorLabel2.backgroundColor = UIColor(hex: palettes[indexPath.row][2])
        cell.colorLabel3.backgroundColor = UIColor(hex: palettes[indexPath.row][4])
        cell.colorLabel4.backgroundColor = UIColor(hex: palettes[indexPath.row][6])
        cell.colorLabel5.backgroundColor = UIColor(hex: palettes[indexPath.row][8])

        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // Replace with your desired height
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
