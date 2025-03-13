import { CreateOrderFromCart, CreateOrderFromCartModel, CreateOrderImmideate, CreateOrderImmideateModel,
  UserOrderItems,
  UserOrderItemsModel } from "."
import { BrandItem, BrandItemModel } from "./brand"


export class RouterTransmintParams{
  totalprice?:number=0
  useid?:number=0
  username?:string=""
  phone?:string=""
  brandItem?:BrandItem=new BrandItemModel({} as BrandItem)
  id?:number=0
  immideateOrder?:CreateOrderImmideate = new CreateOrderImmideateModel({} as CreateOrderImmideate)
  cartOrder?:CreateOrderFromCart = new CreateOrderFromCartModel({} as CreateOrderFromCart)
  userOrderItems?:UserOrderItems = new UserOrderItemsModel({} as UserOrderItems)
}