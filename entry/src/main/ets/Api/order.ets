import { CreateOrderFromCart, CreateOrderImmideate,
  OrderStatusInfo,
  OrderSuccessData, PayOrder,
  PaySuccessData,
  SkuInfoDetail,
  UserOrderList} from "../model";
import { Request_API } from "../utils";


export async  function createOrderImmideate(data:CreateOrderImmideate){
  return await Request_API.post<OrderSuccessData>(`api/orders/immediate`,data)
}

export async  function getSkuInfoDetail(id:number){
  return await Request_API.get<SkuInfoDetail>(`api/sku/${id}`)
}
//从购物车中创建订单
export async  function createOrderFromCart(data:CreateOrderFromCart){
  return await Request_API.post<OrderSuccessData[]>(`api/orders`,data)
}

//支付成功
export async  function paySuccess(data:PayOrder,userId:number,orderId:number){
  return await Request_API.post<PaySuccessData>(`api/orders/${userId}/${orderId}/pay`,data)
}

//用户所有订单数据
export async  function userOrders(user_id:number){
  return await Request_API.get<UserOrderList>(`api/users/${user_id}/orders`)
}
//取消订单
export async  function cancleOrder(user_id:number,order_id:number){
  return await Request_API.post<null>(`api/orders/${user_id}/${order_id}/cancel`)
}

//催发货
export async  function shipOrder(user_id:number,order_id:number){
  return await Request_API.post<null>(`api/orders/${user_id}/${order_id}/ship`)
}

//删除订单
export async  function deleteOrder(user_id:number,order_id:number){
  return await Request_API.delete<null>(`api/orders/${user_id}/${order_id}`)
}

//删除订单
export async  function confrimShouhuo(user_id:number,order_id:number){
  return await Request_API.post<null>(`api/orders/${user_id}/${order_id}/receive`)
}
//不同状态订单
export async  function differentOrderStatus(user_id:number,staus_id:number){
  return await Request_API.get<OrderStatusInfo>(`api/orders/${user_id}/${staus_id}`)
}
