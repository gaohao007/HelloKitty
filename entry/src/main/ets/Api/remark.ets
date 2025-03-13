import { CreateRemark, RemarkContens, Remarks } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getProductRemarks(spu_id:number){
  return await Request_API.get<Remarks>(`api/products/${spu_id}/comments`)
}
// 发表评价

export async  function createRemark(sku_id:number,user_id:number,data:CreateRemark){
  return await Request_API.post<null>(`api/products/${sku_id}/comments/${user_id}`,data)
}
// 获取评价
export async  function getRemark(user_id:number){
  return await Request_API.get<RemarkContens>(`api/users/${user_id}/comments`)
}
// 删除评价
export async  function deleteRemark(id:number,user_id:number){
  return await Request_API.delete<null>(`api/comments/${id}/${user_id}`)
}