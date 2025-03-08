import { AddAddressParams, AddressAreaData, AddressList } from "../model/address";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getUserAddressList(user_id:number){
  return await Request_API.get<AddressList>(`api/users/${user_id}/addresses`)
}

//删除地址

export async  function deleteSomeoneUserSomeoneAddress(user_id:number,address_id:number){
  return await Request_API.delete<null>(`api/users/${user_id}/addresses/${address_id}`)
}

export async  function getProvice(parent_id:number){
  return await Request_API.get<AddressAreaData[]>(`api/locations/${parent_id}`)
}
//新增地址
export async  function insertNewAddress(user_id:number,data:AddAddressParams){
  return await Request_API.post<null>(`api/users/${user_id}/addresses`,data)
}

//新增地址
export async  function updateUserAddressInfo(user_id:number,data:AddAddressParams,addressId:number){
  return await Request_API.put<null>(`api/users/${user_id}/addresses/${addressId}`,data)
}

//修改默认地址
export async  function updateDefalt(user_id:number,addressId:number){
  return await Request_API.put<null>(`api/users/${user_id}/addresses/${addressId}/default`)
}

