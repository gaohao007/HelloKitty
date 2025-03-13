


export interface SkuInfoDetail{
  attributes: string
  created_at: string
  id: number
  image: string
  price: number
  sales_count: number
  spu:SpuInfo
  spu_id: number
  status: number
  stock: number
  version: number
}


export class SkuInfoDetailModel implements SkuInfoDetail{
  attributes: string=""
  created_at: string=""
  id: number=0
  image: string=""
  price: number=0
  sales_count: number=0
  spu:SpuInfo = new SpuInfoModel({} as SpuInfo)
  spu_id: number=0
  status: number=0
  stock: number=0
  version: number=0
  constructor(data:SkuInfoDetail){
    this.attributes=data.attributes
    this.created_at=data.created_at
    this.id=data.id
    this.image=data.image
    this.price=data.price
    this.sales_count=data.sales_count
    this.spu_id=data.spu_id
    this.status=data.status
    this.stock=data.stock
    this.version=data.version
    this.spu=data.spu
  }
}


export interface SpuInfo{
  brand_id: number
  brand_name: string
  category_id: number
  category_name: string
  created_at:string
  description: string
  detail_images:string
  id: number
  is_hot: number
  main_image: string
  name: string
  review_count: number
  sales_count: number
  status: number
  updated_at: string
}

export class SpuInfoModel implements SpuInfo{
  brand_id: number=0
  brand_name: string=""
  category_id: number=0
  category_name: string=""
  created_at:string=""
  description: string=""
  detail_images:string=""
  id: number=0
  is_hot: number=0
  main_image: string=""
  name: string=""
  review_count: number=0
  sales_count: number=0
  status: number=0
  updated_at: string=""
  constructor(data:SpuInfo){
    this.brand_id=data.brand_id
    this.brand_name=data.brand_name
    this.category_id=data.category_id
    this.category_name=data.category_name
    this.created_at=data.created_at
    this.description=data.description
    this.detail_images=data.detail_images
    this.id=data.id
    this.is_hot=data.is_hot
    this.main_image=data.main_image
    this.name=data.name
    this.review_count=data.review_count
    this.sales_count=data.sales_count
    this.status=data.status
    this.updated_at=data.updated_at
  }
}