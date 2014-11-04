//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by James Scott on 7/3/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate  {
    
    var delegate: ItemDetailViewControllerDelegate = ChecklistViewController(coder: NSCoder())
    
    var itemToEdit:ChecklistItem?
    
    @IBOutlet var textField: UITextField?
    
    @IBOutlet var doneBarButton: UIBarButtonItem?
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        delegate.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if let item = itemToEdit    {
            item.text = textField!.text
            delegate.itemDetailViewController(self, didFinishEditingItem: item)
        }
        else    {
            let checklistItem = ChecklistItem(text: textField!.text, checked: false)
            delegate.itemDetailViewController(self, didFinishAddingItem: checklistItem)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(theTextField: UITextField!, shouldChangeCharactersInRange range: Range<String.Index>, replacementString string: String)  -> Bool {
        
        var newText = theTextField.text.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton!.enabled = newText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit    {
            title = "Edit Item"
            textField!.text = item.text
            doneBarButton!.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        textField!.becomeFirstResponder()
    }
    
}

protocol ItemDetailViewControllerDelegate  {
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem: ChecklistItem)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem: ChecklistItem)
    
}