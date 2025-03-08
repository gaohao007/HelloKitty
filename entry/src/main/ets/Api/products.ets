import { ProductItems, Products } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getRandomProducts(){
  return await Request_API.get<Products>('api/random_products')
}
//热销商品
export async  function getHotProducts(){
  return await Request_API.get<Products>('api/hot_products')
}
