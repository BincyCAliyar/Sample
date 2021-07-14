//
//  ViewController.swift
//  MyProduct
//
//  Created by Sijo Thadathil on 12/07/21.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
   
  
   
    var tokenDetails:createTokenDetails?
    var page = 1
    var limit = 10
    var params:[String:String] = [:]
    var sParams = ""
    var sURL:String = String()
   
    var url = NSURL()
    var currentPageDetails = [CurrentPageDetails] ()
    var myCurrentPageDetails:[CurrentPageDetails] = [CurrentPageDetails] ()
    var pageDetails:PageDetails?
    var isLoading: Bool = false
    var flag:[Bool] = Array(repeating: false, count: 33)
    private let spacing:CGFloat = 12.0
    var index = 0
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myProductSearch_TxtFld: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.currentPageDetails.removeAll()
        myProductSearch_TxtFld.layer.cornerRadius = 16.0
        myProductSearch_TxtFld.layer.masksToBounds = true
        self.myCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        ApiCall()
        print(flag)
    }

    @IBAction func MyProductSwitch(_ sender: UISwitch)
    {
        if sender.isOn == true
        {
        index = sender.tag
        flag.insert(true, at: index)
        }
        else
        {
            index = sender.tag
            flag.insert(false, at: index)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return currentPageDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyProductCollectionViewCell
        cell.myProductImage.layer.cornerRadius = 10.0
        let url:NSURL? = NSURL(string: currentPageDetails[indexPath.row].productImage!)
        if url == nil
        {
            cell.myProductImage.image = UIImage(named: "DummyImage")
        }
        else
        {
        cell.myProductImage.sd_setImage(with: url as URL?, completed: nil)
        }
        cell.productName.text = currentPageDetails[indexPath.row].productName
        cell.productPrice.text = currentPageDetails[indexPath.row].price
        cell.productSwitch.tag = indexPath.row
        if flag[indexPath.row] == true
        {
            cell.productSwitch.isOn = true
            
        }
        else
        {
            cell.productSwitch.isOn = false
            
        }
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let numberOfItemsPerRow:CGFloat = 2
               let spacingBetweenCells:CGFloat = 5
               
               let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
               
               if let collection = self.myCollectionView{
                   let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                   return CGSize(width: width, height: width)
               }else{
                   return CGSize(width: 0, height: 0)
               }
        }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//    {
//
//        if !isLoading
//        {
//            if page < (pageDetails?.lastPage)!
//            {
//                page = page + 1
//                productGenerate(page: page)
//            }
//
//        }
//
//    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.lastContentOffset = scrollView.contentOffset.y
//    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        sParams = ""
        sURL = ""
        let offsetY = scrollView.contentOffset.y
        //let offsetX = scrollView.contentOffset.x
        let contentHeight = scrollView.contentSize.height


        if offsetY > contentHeight - scrollView.frame.height

        {
            if !isLoading
            {
                if page < (pageDetails?.lastPage)!
                {
                    page = page + 1
                    productGenerate(page: page)
                }
            }
        }
    }
    func ApiCall()
    {
        let urlStr = "https://gama.e-expo.com/api/user/createToken"
       
        AF.request(urlStr, method:.post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
            switch response.result
            {
            case .success:
               // print(response)
    
                if let jsonData = response.data
                {
                    let responseObject = try? JSONDecoder().decode(CreateToken.self, from: jsonData)
                    self.tokenDetails = responseObject?.data
                    UserDefaults.standard.set(self.tokenDetails?.token, forKey: "isLoggedIn")
                    if UserDefaults.standard.value(forKey: "isLoggedIn") != nil
                    {
                        self.productGenerate(page: self.page)
                    }
                    
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
                }
    }
    
    
    func productGenerate(page:Int)
    {
        
        params = ["user_id":"19", "page":String(page),"limit":String(limit)]
        for (key,value) in params
        {
            sParams += key + "=" + value + "&"
        }
        if !sParams.isEmpty
        {
            sParams = "?" + sParams
            if (sParams.hasSuffix("&"))
            {
                sParams.removeLast()
            }
           sURL = sURL + sParams
            
           
        }
        let urlstr = "https://gama.e-expo.com/api/vendor/myproducts" + sURL
        let headers:HTTPHeaders = ["Authorization":"Bearer " + (UserDefaults.standard.value(forKey: "isLoggedIn") as! String)]
        AF.request(urlstr, method:.post, parameters: nil ,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result
            {
            case .success:
                //self.currentPageDetails.removeAll()
           // print(response)
                if let jsonData = response.data
                {

                     let responseObject = try? JSONDecoder().decode(VendorProduct.self, from: jsonData)
                 // print(responseObject!)
                    
                    self.pageDetails = responseObject?.data
                    self.currentPageDetails = responseObject?.data?.data ?? []
                    self.isLoading = false
                    self.currentPageDetails.append(contentsOf: self.currentPageDetails)
                    self.myCollectionView.reloadData()
                }

                break
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
  
    
}

