

import { BrandItem, Products, } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getBrandDatas(){
  return await Request_API.get<BrandItem[]>('api/brands')
}

// 获取广告数据
export async  function getBrandDatasProducts(id:number){
  return await Request_API.get<Products>(`api/brands/${id}/products`)
}