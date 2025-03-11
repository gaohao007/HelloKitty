import { ColorImages, ProductColors, ProductDetailData, ProductRank, Products, SizeParams, Sizes,
  SkuInfo } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getRandomProducts(){
  return await Request_API.get<Products>('api/random_products')
}
//热销商品
export async  function getHotProducts(){
  return await Request_API.get<Products>('api/hot_products')
}

//获取综合产品数据
export async  function getZongheProducts(){
  return await Request_API.get<ProductRank>( 'api/products/ranked' )
}
//获取价格数据的产品
export async  function getJiageProducts(){
  return await Request_API.get<ProductRank>( 'api/products/by_price' )
}

//获取销量数据的产品
export async  function getSalesCountProducts(){
  return await Request_API.get<ProductRank>( 'api/products/by_sales' )
}

//没件产品的详细信息
export async  function spu_info(spuId:number){
  return await Request_API.get<ProductDetailData>( `api/products/${spuId}`)
}
//获取每件商品的颜色
export async  function getColorsSpu(spuId:number){
  return await Request_API.get<ProductColors>( `api/products/${spuId}/colors`)
}

//获取每件商品的尺寸
export async  function getSizeData(spuId:number,color:string){
  return await Request_API.get<ColorImages>( `api/products/${spuId}/colors/${color}/images`)
}

// getSiezs
export async  function getSizes(spuId:number){
  return await Request_API.get<Sizes>( `api/products/${spuId}/sizes`)
}


//getsku
export async  function getSkuInfo(spuId:number,color:string,size:string){
  return await Request_API.get<SkuInfo>( `api/skus/${spuId}/${color}/${size}`)
}










