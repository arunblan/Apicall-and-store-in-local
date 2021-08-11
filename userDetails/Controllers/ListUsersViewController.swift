

import UIKit
import MBProgressHUD
class ListUsersViewController: UIViewController {

    private  var httpUtillity : HttpUtility?
    @IBOutlet weak var tableviewOut: UITableView!
    var userDetailsResponce = [Datum]()
    var imageHandler = ImageHandler()
    
    var pageNumber:Int = 1
    var totalPage:Int = 0
    
    private let userManger:UserManger = UserManger()
    var userResponce : [LocalUserResponce]? = []
    
    var showOfflineData:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Got error from api
        
//        let url = URL(string: "https://reqres.in/api/users?page=1")
//        httpUtillity?.getApiData(requestUrl: url!, resultType: userDetailsLists.self) { (responce) in
//            print(responce.data)
//
//        }
        
        
        let nibDate = UINib(nibName: "UserListTableViewCell", bundle: nil)
        self.tableviewOut.register(nibDate, forCellReuseIdentifier: "UserListTableViewCell")
        httpUtillity = HttpUtility()
        showOfflineData ? showLocalData() : userListApiCall()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkHandler.checkInternetConnected(viewController: self)
    }
    
    func userListApiCall(){
        print(pageNumber)
        MBProgressHUD.showAdded(to: view, animated: true)
        let url = URL(string: "https://demo5533019.mockable.io/page\(pageNumber)")
        httpUtillity?.getApiData(requestUrl: url!, resultType: userDetailsLists.self) { (responce) in
            print(responce.data)
            self.totalPage = responce.totalPages
            self.userDetailsResponce.append(contentsOf: responce.data)
            self.addedToLocal()
            DispatchQueue.main.async() {
                self.tableviewOut.reloadData()
                
            }
        }
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    
    //Get data from DB
    func showLocalData(){
        
        userResponce = userManger.fetchuser()
        if userResponce?.count == 0{
            AlertHandler.showAlert(title: "Alert", message: "There is no data", color: .black, target: self)
        }else{
            
        }
        
    }
    
    //Add data to local DB
    func addedToLocal(){
        for userdata in userDetailsResponce{
            if UserDataRepository.checkUserId(with: userdata.id ?? 0){
                let user = LocalUserResponce(id: userdata.id, email: userdata.email, firstName: userdata.firstName, lastName: userdata.lastName, avatar:userdata.avatar)
                userManger.createUser(user: user)
            }else{
                print("userisThere")
            }
        }
       
        
    }

    
    //Showdetails page
    func showUserDetails(userDatas:Datum){
        let push = self.storyboard?.instantiateViewController(identifier: "UserDetailsViewController") as! UserDetailsViewController
        push.userData = userDatas
        print(userDatas.email)
        self.navigationController?.pushViewController(push, animated: true)
    }

}




//UserListTableViewCell
extension ListUsersViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showOfflineData ?  userResponce?.count ?? 0 :  userDetailsResponce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as! UserListTableViewCell
        
        cell.nameLbl.text = showOfflineData ? userResponce?[indexPath.row].firstName : userDetailsResponce[indexPath.row].firstName
        ImageHandler.imageHandler(url: "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg", imageView: cell.imageOut)
        cell.imageOut.makeRounded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableviewOut.deselectRow(at: indexPath, animated: true)
        if showOfflineData{
            print(userResponce?[indexPath.row].firstName)
            showUserDetails(userDatas: Datum(id: userResponce?[indexPath.row].id, email: userResponce?[indexPath.row].email, firstName: userResponce?[indexPath.row].firstName, lastName: userResponce?[indexPath.row].lastName, avatar: userResponce?[indexPath.row].avatar))
        }else{
            showUserDetails(userDatas: userDetailsResponce[indexPath.row])
        }
    }
    
}


extension ListUsersViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if ((tableviewOut.contentOffset.y + tableviewOut.frame.size.height) >= tableviewOut.contentSize.height){
            if pageNumber <= totalPage{
                pageNumber += 1
                userListApiCall()
                print("s")
            }

        }
    }
}
