import { Category, Products } from "../model";
import { Request_API } from "../utils";


//获取销量数据的产品
export async  function getCategoryList(){
  return await Request_API.get<Category[]>( 'api/categories' )
}

//获取某某品牌的商品数据

export async  function getCategoryData(category_id:number){
  return await Request_API.get<Products>( `api/categories/${category_id}/products`)
}