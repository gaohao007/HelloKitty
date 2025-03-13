

export interface  CreateOrderImmideate{
  user_id ?: number
  sku_id ?: number
  quantity ?: number
  address_id ?: number
}
export class  CreateOrderImmideateModel implements CreateOrderImmideate{
  user_id ?: number =0
  sku_id ?: number=0
  quantity ?: number=0
  address_id ?: number=0
  constructor(model:CreateOrderImmideate){
    this.user_id = model.user_id
    this.sku_id = model.sku_id
    this.quantity = model.quantity
    this.address_id = model.address_id
  }
}

export interface OrderSuccessData{
  order_id: number
  order_no: string
  total_amount: number
}
export class OrderSuccessDataModel implements OrderSuccessData{
  order_id: number =0
  order_no: string =""
  total_amount: number =0
  constructor(model:OrderSuccessData){
    this.order_id = model.order_id
    this.order_no = model.order_no
    this.total_amount = model.total_amount
  }
}
//从购物车中创建订单

export interface CreateOrderFromCart{
  user_id: number
  cart_items: CartItems[]
  address_id?: number
}

export class CreateOrderFromCartModel implements CreateOrderFromCart{
  user_id: number =0
  cart_items: CartItems[] =[]
  address_id ?: number=0
  constructor(model:CreateOrderFromCart){
    this.user_id = model.user_id
    this.cart_items = model.cart_items
    this.address_id = model.address_id
  }
}

export interface CartItems{
  id: number
  sku_id: number
  quantity: number
}
export class CartItemsModel implements CartItems{
  id: number =0
  sku_id: number =0
  quantity: number =0
  constructor(model:CartItems){
    this.id = model.id
    this.sku_id = model.sku_id
    this.quantity = model.quantity
  }
}

//订单支付
export interface PayOrder{
  address_id: number
}
export class PayOrderModel implements PayOrder{
  address_id: number =0
  constructor(model:PayOrder){
    this.address_id = model.address_id
  }
}
export interface  PaySuccessData{
  logistics_no: string
  order_id: number
  payment_no: string
  status: number
}

export class PaySuccessDataModel implements PaySuccessData{
  logistics_no: string =""
  order_id: number =0
  payment_no: string =""
  status: number =0
  constructor(model:PaySuccessData){
    this.logistics_no = model.logistics_no
    this.order_id = model.order_id
    this.payment_no = model.payment_no
    this.status = model.status
  }
}
//所有的订单数据
export interface UserOrderList{
  items:UserOrderItems[]
  total:number
}
export class UserOrderListModel implements UserOrderList{
  items:UserOrderItems[] =[]
  total:number =0
  constructor(model:UserOrderList){
    this.items = model.items
    this.total = model.total
  }
}


export interface UserOrderItems{

  address_city: string
  address_detail: string
  address_district: string
  address_id:number
  address_name: string
  address_phone: string
  address_province: string
  created_at: string
  delivery_time:string | null
  finish_time: string| null
  id:number
  items:UserOrderItemsItems[]
  order_no: string
  pay_time: string| null
  status: number
  total_amount: number
}

export class UserOrderItemsModel implements UserOrderItems{
  address_city: string =""
  address_id:number=0
  address_detail: string =""
  address_district: string =""
  address_name: string =""
  address_phone: string =""
  address_province: string =""
  created_at: string =""
  delivery_time:string | null =null
  finish_time: string| null =null
  id:number =0
  items:UserOrderItemsItems[] =[]
  order_no: string =""
  pay_time: string| null =null
  status: number =0
  total_amount: number =0
  constructor(model:UserOrderItems){
    this.address_city = model.address_city
    this.address_detail = model.address_detail
    this.address_district = model.address_district
    this.address_name = model.address_name
    this.address_phone = model.address_phone
    this.address_province = model.address_province
    this.created_at = model.created_at
    this.delivery_time = model.delivery_time
    this.finish_time = model.finish_time
    this.id = model.id
    this.items = model.items
    this.order_no = model.order_no
    this.pay_time = model.pay_time
    this.status = model.status
    this.total_amount = model.total_amount
    this.address_id = model.address_id
  }
}




export interface UserOrderItemsItems{
  price: number
  quantity: number
  sku_attributes:sku_attributes_items[]
  sku_id: number
  sku_image: string
  sku_name: string
  spu_description: string
  spu_main_image: string
}

export class UserOrderItemsItemsModel implements UserOrderItemsItems{
  price: number =0
  quantity: number =0
  sku_attributes:sku_attributes_items[] =[]
  sku_id: number =0
  sku_image: string =""
  sku_name: string =""
  spu_description: string =""
  spu_main_image: string =""
  constructor(model:UserOrderItemsItems){
    this.price = model.price
    this.quantity = model.quantity
    this.sku_attributes = model.sku_attributes
    this.sku_id = model.sku_id
    this.sku_image = model.sku_image
    this.sku_name = model.sku_name
    this.spu_description = model.spu_description
    this.spu_main_image = model.spu_main_image
  }
}

export interface sku_attributes_items{
  color: string
  size: string
}
export class sku_attributes_itemsModel implements sku_attributes_items{
  color: string =""
  size: string =""
  constructor(model:sku_attributes_items){
    this.color = model.color
    this.size = model.size
  }
}




//不同状态的订单
export interface  OrderStatusInfo{
  orders: OrderStatusInfoItems[]
  total:number
}

export class OrderStatusInfoModel implements OrderStatusInfo{
  orders: OrderStatusInfoItems[] =[]
  total:number =0
  constructor(model:OrderStatusInfo){
    this.orders = model.orders
    this.total = model.total
  }
}

export interface OrderStatusInfoItems{
  address: AddressInfoItem |null
  created_at:string
  delivery_time: string | null
  
  finish_time:string | null
  id: number
  items:Sku_items[]
  
  logistics: LogisticsInfoItem| null
  order_no:string
  pay_time:string | null
  
  payment: PaymentInfoItem | null
  payment_method: number
  spu_description: string
  
  spu_main_image:string
  status: number
  total_amount: number
  
  user_id: number
}
export class OrderStatusInfoItemsModel implements OrderStatusInfoItems{
  address: AddressInfoItem |null =null
  created_at:string =""
  delivery_time: string | null =null
  
  finish_time:string | null =null
  id: number =0
  items:Sku_items[] =[]
  
  logistics: LogisticsInfoItem| null =null
  order_no:string =""
  pay_time:string | null =null
  
  payment: PaymentInfoItem | null =null
  payment_method: number =0
  spu_description: string =""
  
  spu_main_image:string =""
  status: number =0
  total_amount: number =0
  
  user_id: number=0

  constructor(data:OrderStatusInfoItems) {
    this.address = data.address
    this.created_at = data.created_at
    this.delivery_time = data.delivery_time
    this.finish_time = data.finish_time
    this.id = data.id
    this.items = data.items
    this.logistics = data.logistics
    this.order_no = data.order_no
    this.pay_time = data.pay_time
    this.payment = data.payment
    this.payment_method = data.payment_method
    this.spu_description = data.spu_description
    this.spu_main_image = data.spu_main_image
    this.status = data.status
    this.total_amount = data.total_amount
    this.user_id = data.user_id
  }
}




export interface AddressInfoItem{
  address_id: number
  id: number
  order_id: number
  user_id: number
}
export class AddressInfoItemModel implements AddressInfoItem{
  address_id: number =0
  id: number =0
  order_id: number =0
  user_id: number =0
  constructor(model:AddressInfoItem){
    this.address_id = model.address_id
    this.id = model.id
    this.order_id = model.order_id
    this.user_id = model.user_id
  }
}








export interface Sku_items{
  id: number
  order_id: number
  price: number
  quantity: number
  sku_attributes:string
  sku_id: number
  sku_image: string
  sku_name: string
  spu_description: string
  spu_main_image: string
  specs:SpecItem | null
}

export class Sku_itemsModel implements Sku_items{
  id: number =0
  order_id: number =0
  price: number =0
  quantity: number =0
  sku_attributes:string =""
  sku_id: number =0
  sku_image: string =""
  sku_name: string =""
  spu_description: string =""
  spu_main_image: string =""
  specs:SpecItem |null =null
  constructor(model:Sku_items){
    this.id = model.id
    this.order_id = model.order_id
    this.price = model.price
    this.quantity = model.quantity
    this.sku_attributes = model.sku_attributes
    this.sku_id = model.sku_id
    this.sku_image = model.sku_image
    this.sku_name = model.sku_name
    this.spu_description = model.spu_description
    this.spu_main_image = model.spu_main_image
    this.specs = model.specs
  }
}



export interface LogisticsInfoItem{
  company_code:string
  company_name: string
  created_at:string
  id: number
  logistics_no: string
  order_id: number
  receiver_address:string
  receiver_name: string
  receiver_phone:string
}

export class LogisticsInfoItemModel implements LogisticsInfoItem{
  company_code:string =""
  company_name: string =""
  created_at:string =""
  id: number =0
  logistics_no: string =""
  order_id: number =0
  receiver_address:string =""
  receiver_name: string =""
  receiver_phone:string =""
  constructor(model:LogisticsInfoItem){
    this.company_code = model.company_code
   this.company_name = model.company_name
    this.created_at = model.created_at
    this.id = model.id
    this.logistics_no = model.logistics_no
    this.order_id = model.order_id
    this.receiver_address = model.receiver_address
    this.receiver_name = model.receiver_name
    this.receiver_phone = model.receiver_phone
  }
}


export interface PaymentInfoItem{
  amount: number
  created_at: string
  id: number
  order_id: number
  payment_no: string
  payment_time: string
  status: number
}

export class PaymentInfoItemModel implements PaymentInfoItem{
  amount: number =0
  created_at: string =""
  id: number =0
  order_id: number =0
  payment_no: string =""
  payment_time: string =""
  status: number =0
  constructor(model:PaymentInfoItem){
    this.amount = model.amount
    this.created_at = model.created_at
    this.id = model.id
    this.order_id = model.order_id
    this.payment_no = model.payment_no
    this.payment_time = model.payment_time
    this.status = model.status
  }
}



export interface SpecItem{
  color: string
  size: string
}

export class SpecItemModel implements SpecItem{
  color: string =""
  size: string =""
  constructor(model:SpecItem){
    this.color = model.color
    this.size = model.size
  }
}


































































































































































































































































