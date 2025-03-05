import { ProductItems, Products } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getRandomProducts(){
  return await Request_API.get<Products>('api/random_products')
}
