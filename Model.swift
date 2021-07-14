
import Foundation

// Create Token

class CreateToken:Codable
{
    var errorCode:Int?
    var data:createTokenDetails?
    var message:String?
    
    enum CodingKeys:String ,CodingKey
    {
        case errorCode = "errorcode"
        case data
        case message
    }
    
    init(errorCode:Int?,data:createTokenDetails?,message:String?)
    {
        self.errorCode = errorCode
        self.data = data
        self.message = message
    }
}

class createTokenDetails:Codable
{
    var user_id:Int?
    var token:String?
    
    enum CodingKeys:String ,CodingKey
    {
        case user_id
        case token
    }
    
    init(user_id:Int?, token:String?)
    {
        self.user_id = user_id
        self.token = token
    }
}



//MyProduct


class VendorProduct:Codable
{
    var errorCode:Int?
    var data:PageDetails?
    var message:String?
    
    init(errorCode:Int?, data:PageDetails?, message:String?)
    {
        self.errorCode = errorCode
        self.data = data
        self.message = message
    }
}

class PageDetails:Codable
{
    var currentPage:Int?
    var data:[CurrentPageDetails]?
    var firstPageURL:String?
    var from:Int?
    var lastPage:Int?
    var lastPageURL:String?
    var nextPageURL:String?
    var path:String?
    var perPage:String?
    var prevPageURL:String?
    var to:Int?
    var total:Int?
    
    
    enum CodingKeys:String ,CodingKey
    {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to
        case total
    }
    
    init(currentPage:Int?, data:[CurrentPageDetails]?, firstPageURL:String?, from:Int?, lastPage:Int?, lastPageURL:String?, nextPageURL:String?, path:String?, perPage:String?, prevPageURL:String?, to:Int?, total:Int?)
    {
        self.currentPage = currentPage
        self.data = data
        self.firstPageURL = firstPageURL
        self.from = from
        self.lastPage = lastPage
        self.lastPageURL = lastPageURL
        self.nextPageURL = nextPageURL
        self.path = path
        self.perPage = perPage
        self.prevPageURL = prevPageURL
        self.to = to
        self.total = total
    }
    
}

class CurrentPageDetails:Codable
{
    var productId:Int?
    var productName:String?
    var productModel:String?
    var productImage:String?
    var price:String?
    var isActivated:Bool?
    
    enum CodingKeys:String ,CodingKey
    {
        case productId = "product_id"
        case productName = "product_name"
        case productModel = "product_model"
        case productImage = "product_image"
        case price
        case isActivated
    }
    
    init(productId:Int?, productName:String?, productModel:String?, productImage:String?, price:String?, isActivated:Bool?)
    {
        self.productId = productId
        self.productName = productName
        self.productModel = productModel
        self.productImage = productImage
        self.price = price
        self.isActivated = isActivated
    }
}
