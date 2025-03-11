import { Remarks } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getProductRemarks(spu_id:number){
  return await Request_API.get<Remarks>(`api/products/${spu_id}/comments`)
}