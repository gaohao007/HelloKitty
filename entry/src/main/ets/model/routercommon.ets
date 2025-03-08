import { BrandItem, BrandItemModel } from "./brand"


export class RouterTransmintParams{
  useid?:number=0
  username?:string=""
  phone?:string=""
  brandItem?:BrandItem=new BrandItemModel({} as BrandItem)
}