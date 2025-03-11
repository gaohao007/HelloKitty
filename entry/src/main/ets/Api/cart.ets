import { CreatCartParams, SelectOrCancleParams, UpdateCartquantity, UserCarts } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getCartData(user_id:number){
     return await Request_API.get<UserCarts>(`api/cart/${user_id}`)
}
//取消还是选中勾选
export async  function isCancelOrSelect(user_id:number,item_id:number,data:SelectOrCancleParams){
     return await Request_API.put<null>(`api/cart/${user_id}/${item_id}/select`,data)
}
//删除购物车某个商品
export async  function deleteSomeOneCartItem(user_id:number,item_id:number,){
     return await Request_API.delete<null>(`api/cart/${user_id}/${item_id}`)
}
//更新购物车商品的数量
export async  function updateCartQuantity(user_id:number,item_id:number,data:UpdateCartquantity){
     return await Request_API.put<null>(`api/cart/${user_id}/${item_id}`,data)
}
//创建购物车
export async  function createCartItems(user_id:number,data:CreatCartParams){
     return await Request_API.post<null>(`api/cart/${user_id}`,data)
}