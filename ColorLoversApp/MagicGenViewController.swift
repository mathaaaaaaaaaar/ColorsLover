//
//  MagicGenViewController.swift
//  ColorLoversApp
//

import UIKit
import CoreData

class MagicGenViewController: UIViewController, XMLParserDelegate {

    var currentElement = ""
    var currentPalette: [String: String] = [:]
    var palettes: [[String: String]] = []
    var colors: [String] = []
    var counter = 0;

    @IBOutlet weak var paletteColor1: UILabel!
    @IBOutlet weak var paletteColor2: UILabel!
    @IBOutlet weak var paletteColor3: UILabel!
    @IBOutlet weak var paletteColor4: UILabel!
    @IBOutlet weak var paletteColor5: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomColorPalette()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        fetchRandomColorPalette()
    }

    func fetchRandomColorPalette() {
        let url = URL(string: "https://www.colourlovers.com/api/palettes/random")
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                DispatchQueue.main.async {
                    // Update UI with self.colors
                    self.updateUIWithNewColors()
                }
            }
        }
        task.resume()
    }

    func updateUIWithNewColors() {
        // Update your UI with the new colors here
        self.paletteColor1.text = "#" + self.colors[self.counter*11]
        self.paletteColor1.backgroundColor = UIColor(hex: "\(self.colors[self.counter*11])")
        self.paletteColor2.text = "#" + self.colors[(self.counter*11)+2]
        self.paletteColor2.backgroundColor = UIColor(hex: "\(self.colors[(self.counter*11)+2])")
        self.paletteColor3.text = "#" + self.colors[(self.counter*11)+4]
        self.paletteColor3.backgroundColor = UIColor(hex: "\(self.colors[(self.counter*11)+4])")
        self.paletteColor4.text = "#" + self.colors[(self.counter*11)+6]
        self.paletteColor4.backgroundColor = UIColor(hex: "\(self.colors[(self.counter*11)+6])")
        self.paletteColor5.text = "#" + self.colors[(self.counter*11)+8]
        self.paletteColor5.backgroundColor = UIColor(hex: "\(self.colors[(self.counter*11)+8])")
        self.counter += 1
    }

    // XMLParserDelegate methods

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // Handle start of an element
        currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Handle the content of an element
        if currentElement == "hex" {
                    colors.append(string)
                }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // Handle end of an element
        if elementName == "palette" {
            palettes.append(currentPalette)

            // Save the palette to Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Palette", in: context)!
            let newPalette = NSManagedObject(entity: entity, insertInto: context)

            newPalette.setValue(colors, forKey: "palettes")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

            currentPalette = [:]
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // Handle parsing error
        print("Error parsing XML: \(parseError)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
