//
//  main.swift
//  myKiosk
//
//  Created by 윤규호 on 12/4/23.
//

class Main {
    struct Menu {
        let no: Int
        let name: String
        let info: String
        let price: Float
    }
    var myWallet: Double = 7
    var myCart: Float = 0
    var mainMenu: [Menu] = []
    
    init() {
        let def = Menu(no: 0, name: "종료", info: "프로그램 종료", price:0)
        let menu1 = Menu(no: 1, name: "Burgers", info: "앵거스 비프 통살을 다져만든 버거", price:0)
        let menu2 = Menu(no: 2, name: "Frozen Custard", info: "매장에서 신선하게 만드는 아이스크림", price:0)
        let menu3 = Menu(no: 3, name: "Drinks", info: "매장에서 직접 만드는 음료", price:0)
        let menu4 = Menu(no: 4, name: "Beer", info: "뉴욕 브루클린 브루어리에서 양조한 맥주", price:0)
        
        mainMenu.append(def)
        mainMenu.append(menu1)
        mainMenu.append(menu2)
        mainMenu.append(menu3)
        mainMenu.append(menu4)
    }
    
    func greet() {
        print("아래 메뉴판을 보시고 메뉴를 골라 입력해주세요.\n")
        print("[ SHAKESHACK MENU ]")
        
        for item in mainMenu {
            let nameLength = 25
            let infoLength = 40
            
            let nameSpaces = String(repeating: " ", count: max(0, nameLength - item.name.count))
            let infoSpaces = String(repeating: " ", count: max(0, infoLength - item.info.count))
            
            print("\(item.no). \(item.name)\(nameSpaces) | \(item.info)\(infoSpaces)")
        }
        print(
            """
            \n[ ORDER MENU ]
            5. Order    | 장바구니 확인 후 주문합니다.
            6. Cancel   | 진행중인 주문을 취소합니다.
            """
        )
        if let input = readLine(), let input = Int(input){
            switch(input){
            case 0: exit(0)
            case 1: burgers.greet1()
            case 2: icecream.greet1()
            case 3: drink.greet1()
            case 4: beer.greet1()
            case 5: myOrder.greet1()
            case 6: 
                myOrder.deleteCart()
                greet()
            default:
                print("잘못된 번호를 입력했어요 다시 입력해주세요.\n")
                kiosk.greet()
            }
        }else{
            print("잘못된 번호를 입력했어요 다시 입력해주세요.\n")
            kiosk.greet()
        }
    }
    func cart(_ menu: String, _ price: String){
        print("위 메뉴를 장바구니에 추가하시겠습니까?")
        print("1.확인     2.취소")
        let input:Int = Int(readLine()!)!
        
        if input == 1
        {
            print("\(menu)가 장바구니에 추가되었습니다.")
            myOrder.addCart(menu, price)
        }
        else if input == 2
        {
            print("이전 단계로 돌아갑니다.")
        }
        else
        {
            print("잘못 입력하셨습니다. 다시 입력해주세요.")
        }
    }
}

class Order: Main{
    var item:[String] = []
    var prices:[String] = []
    var totalPrice: Double = 0
    
    func addCart(_ name: String, _ price: String){
        item += [name]
        prices += [price]
        totalPrice += Double(price)!
    }
    func deleteCart(){
        item = []
        prices = []
        totalPrice = 0
        print("장바구니를 비웠습니다. 다시 담아주세요.")
    }
    
    func greet1(){
        print("\n아래와 같이 주문하시겠습니까?")
        print("[ Orders ]")
        for i in 0..<item.count{
            print("\(item[i]) |  W \(prices[i])")
        }
        print("\n[ Total ]")
        print("W \(totalPrice)")
        print("1. 주문      2. 메뉴판")
        
        let input:Int = Int(readLine()!)!
        
        if input == 1
        {
            if myWallet >= totalPrice
            {
                print("구매성공 !!!!")
                myWallet -= totalPrice
            }
            else
            {
                print("현재 잔액은 \(myWallet)W 으로 \(totalPrice-myWallet)W 이 부족해서 주문할 수 없습니다.")
                print("장바구니를 비우고 다시 시도해주세요. (6. Cancel)")
                super.greet()
            }
        }
        else if input == 2
        {
            print("이전 단계로 돌아갑니다.")
            super.greet()
        }
        else
        {
            print("잘못 입력하셨습니다. 다시 입력해주세요.")
            super.greet()
        }
    }
}

class Burgers: Main{
    var burgersMenu: [Menu] = []
    
    override init() {
        let def = Menu(no: 0, name: "뒤로가기", info: "뒤로가기", price:0)
        let menu1 = Menu(no: 1, name: "ShackBurger", info: "앵거스 비프 통살을 다져만든 버거", price:6.9)
        let menu2 = Menu(no: 2, name: "SmokeShack", info: "베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거", price:8.9)
        let menu3 = Menu(no: 3, name: "Shroom Burger", info: "몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거", price:9.4)
        let menu4 = Menu(no: 4, name: "Cheeseburger", info: "포테이토 번과 비프패티, 치즈가 토핑된 치즈버거", price:6.9)
        let menu5 = Menu(no: 5, name: "Hamburger", info: "비프패티를 기반으로 야채가 들어간 기본버거", price:5.4)
        
        burgersMenu.append(def)
        burgersMenu.append(menu1)
        burgersMenu.append(menu2)
        burgersMenu.append(menu3)
        burgersMenu.append(menu4)
        burgersMenu.append(menu5)
    }
    
    func greet1() {
        print("[ Burgers MENU ]")
        let nameLength = 25
        let infoLength = 40
        
        for item in burgersMenu {
            let nameSpaces = String(repeating: " ", count: max(0, nameLength - item.name.count))
            let priceSpaces = String(repeating: " ", count: 4)
            let infoSpaces = String(repeating: " ", count: max(0, infoLength - item.info.count))
            
            print("\(item.no). \(item.name)\(nameSpaces) | W\(item.price)\(priceSpaces) | \(item.info)\(infoSpaces)")
        }
        let input:Int = Int(readLine()!)!

        switch(input){
        case 0: kiosk.greet()
        case 1: 
            print("\(burgersMenu[input].name)  |  \(burgersMenu[input].price)  |  \(burgersMenu[input].info)")
            cart(burgersMenu[input].name, String(burgersMenu[input].price))
            greet1()
        case 2:
            print("\(burgersMenu[input].name)  |  \(burgersMenu[input].price)  |  \(burgersMenu[input].info)")
            cart(burgersMenu[input].name, String(burgersMenu[input].price))
            greet1()
        case 3:
            print("\(burgersMenu[input].name)  |  \(burgersMenu[input].price)  |  \(burgersMenu[input].info)")
            cart(burgersMenu[input].name, String(burgersMenu[input].price))
            greet1()
        case 4:
            print("\(burgersMenu[input].name)  |  \(burgersMenu[input].price)  |  \(burgersMenu[input].info)")
            cart(burgersMenu[input].name, String(burgersMenu[input].price))
            greet1()
        case 5:
            print("\(burgersMenu[input].name)  |  \(burgersMenu[input].price)  |  \(burgersMenu[input].info)")
            cart(burgersMenu[input].name, String(burgersMenu[input].price))
            greet1()
        default:
            print("잘못된 번호를 입력했어요 다시 입력해주세요.")
            greet1()
        }
    }
}

class Icecream: Main{
    func greet1(){
        print("아이스크림 메뉴 출력")
    }
}

class Drink: Main{
    func greet1(){
        print("음료수 메뉴 출력")
    }
}

class Beer: Main{
    func greet1(){
        print("맥주 메뉴 출력")
    }
}

//main

let kiosk = Main()
let burgers = Burgers()
let icecream = Icecream()
let drink = Drink()
let beer = Beer()
let myOrder = Order()

kiosk.greet()
