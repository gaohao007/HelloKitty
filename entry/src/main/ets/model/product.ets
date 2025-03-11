

export interface Products{
  items:ProductItems[]
}
export class ProductsModel implements Products{
  items:ProductItems[]=[]

  constructor(model:Products) {
    this.items = model.items
  }
}



export interface ProductItems{
  brand_id: number,
  brand_name: string,
  category_id: number,
  category_name: string,
  created_at: string,
  description: string,
  detail_images: string,
  id: number,
  is_hot: number,
  main_image:string,
  name: string,
  review_count: number,
  sales_count: number,
  skus:Sku_Items[]
  status:number,
  updated_at:string
}

export class ProductItemsModel implements ProductItems{
  brand_id: number=0
  brand_name: string=''
  category_id: number=0

  category_name: string=''
  created_at: string=''
  description: string=''

  detail_images: string=''
  id: number=0
  is_hot: number=0

  main_image:string=''
  name: string=''
  review_count: number=0

  sales_count: number=0
  status:number=0
  updated_at:string=''

  skus:Sku_Items[]=[]

  constructor(model:ProductItems) {
    this.brand_id = model.brand_id
    this.brand_name = model.brand_name
    this.category_id = model.category_id
    this.category_name = model.category_name
    this.created_at = model.created_at

    this.description = model.description
    this.detail_images = model.detail_images
    this.id = model.id
    this.is_hot = model.is_hot
    this.main_image = model.main_image

    this.name = model.name
    this.review_count = model.review_count

    this.sales_count = model.sales_count
    this.status = model.status
    this.updated_at = model.updated_at
    this.skus = model.skus

  }
}




export interface Sku_Items{
  attributes: string,
  created_at: string,
  id: number,
  image: string,
  price: number,
  sales_count: number,
  spu_id: number,
  status: number,
  stock: number,
  version: number
}

export class Sku_ItemsModel implements  Sku_Items{
  attributes: string=''
  created_at: string=''
  id: number=0

  image: string=''
  price: number=0
  sales_count: number=0

  spu_id: number=0
  status: number=0
  stock: number=0

  version: number=0

  constructor(model:Sku_Items) {
    this.attributes = model.attributes
    this.created_at = model.created_at
    this.id = model.id

    this.image = model.image
    this.price = model.price
    this.sales_count = model.sales_count

    this.spu_id = model.spu_id
    this.status = model.status
    this.stock = model.stock

    this.version = model.version
  }

}






// 综合产品数据类型
export interface ProductRank{
  items:ProductRankItems[]
}
export class ProductRankModel implements ProductRank{
  items:ProductRankItems[]=[]

  constructor(model:ProductRank) {
    this.items = model.items
  }
}


export interface ProductRankItems{
  avg_price: number
  brand_name: string
  category_name:string
  spu_created_at:string
  spu_description: string
  spu_detail_images: string
  spu_id: number
  spu_is_hot: number
  spu_main_image: string
  spu_name: string
  spu_review_count: number
  spu_sales_count: number
  spu_status: number
  spu_updated_at:string
  total_sales?: number
}

export class ProductRankItemsModel implements ProductRankItems{
  avg_price: number=0
  brand_name: string=''
  category_name:string=''
  spu_created_at:string=''
  spu_description: string=''
  spu_detail_images: string=''
  spu_id: number=0
  spu_is_hot: number=0
  spu_main_image: string=''
  spu_name: string=''
  spu_review_count: number=0
  spu_sales_count: number=0
  spu_status: number=0
  spu_updated_at:string=''
  total_sales?: number=0
  constructor(model:ProductRankItems) {
    this.avg_price = model.avg_price
    this.brand_name = model.brand_name
    this.category_name = model.category_name

    this.spu_created_at = model.spu_created_at
    this.spu_description = model.spu_description
    this.spu_detail_images = model.spu_detail_images

    this.spu_id = model.spu_id
    this.spu_is_hot = model.spu_is_hot
    this.spu_main_image = model.spu_main_image

    this.spu_name = model.spu_name
    this.spu_review_count = model.spu_review_count
    this.spu_sales_count = model.spu_sales_count

    this.spu_status = model.spu_status
    this.spu_updated_at = model.spu_updated_at
    this.total_sales = model.total_sales
  }
}



export interface ProductDetailData{
  brand_name: string
  category_name: string
  created_at: string
  description: string
  detail_images:string[],
  id:number
  is_hot: number
  main_image: string
  name: string
  review_count: number
  sales_count: number
  skus:SkuItems[],
  status: number
  updated_at: string
}

export class  ProductDetailDataModel implements ProductDetailData{
  brand_name: string=''
  category_name: string=''
  created_at: string=''
  description: string=''
  detail_images:string[]=[]
  id:number=0
  is_hot: number=0
  main_image: string=''
  name: string=''
  review_count: number=0
  sales_count: number=0
  skus:SkuItems[]=[]
  status: number=0
  updated_at: string=''
  constructor(model:ProductDetailData) {
    this.brand_name = model.brand_name
    this.category_name = model.category_name
    this.created_at = model.created_at
    this.description = model.description
    this.detail_images = model.detail_images
    this.id = model.id
    this.is_hot = model.is_hot
    this.main_image = model.main_image
    this.name = model.name
    this.review_count = model.review_count
    this.sales_count = model.sales_count
    this.skus = model.skus
    this.status = model.status
    this.updated_at = model.updated_at
  }
}



export  interface SkuItems{
  attributes:AttributesItem[]
  created_at: string
  id: number
  image:string[]
  price: number
  sales_count: number
  spu_id: number
  status: number
  stock: number
  version: number
}
export class SkuItemsModel implements SkuItems{
  attributes:AttributesItem[]=[]
  created_at: string=''
  id: number=0
  image:string[]=[]
  price: number=0
  sales_count: number=0
  spu_id: number=0
  status: number=0
  stock: number=0
  version: number=0

  constructor(model:SkuItems) {
    this.attributes = model.attributes
    this.created_at = model.created_at
    this.id = model.id
    this.image = model.image
    this.price = model.price
    this.sales_count = model.sales_count
    this.spu_id = model.spu_id
    this.status = model.status
    this.stock = model.stock
    this.version = model.version
  }
}




export interface AttributesItem{
  attribute_id:number
  value: string
}

export  class AttributesItemModel implements AttributesItem{
  attribute_id:number=0
  value: string=''
  constructor(model:AttributesItem) {
    this.attribute_id = model.attribute_id
    this.value = model.value
  }
}



export interface ProductColors{
  colors:string[]
}
export class ProductColorsModel implements ProductColors{
  colors:string[]=[]
  constructor(model:ProductColors) {
    this.colors = model.colors
  }
}

export interface ColorImages{
  color: string
  images: string[]
  spu_id:number
}

export class ColorImagesModel implements ColorImages{
  color: string=''
  images: string[]=[]
  spu_id:number=0
  constructor(model:ColorImages) {
    this.color = model.color
    this.images = model.images
    this.spu_id = model.spu_id
  }
}

export interface Sizes{
  sizes: string[]
}
export class SizesModel implements Sizes{
  sizes: string[]=[]
  constructor(model:Sizes) {
    this.sizes = model.sizes
  }
}

export class  SizeParams{
  color:string=""
  constructor(  color:string) {
    this.color = color
  }
}






export interface SkuInfo{
  attributes: string
  created_at: string
  id: number
  image: string[]
  price: number
  sales_count:number
  spu_id: number
  status: number
  stock: number
  version: number
}
export class SkuInfoModel implements SkuInfo{
  attributes: string=''
  created_at: string=''
  id: number=0
  image: string[]=[]
  price: number=0
  sales_count:number=0
  spu_id: number=0
  status: number=0
  stock: number=0
  version: number=0

  constructor(model:SkuInfo) {
    this.attributes = model.attributes
    this.created_at= model.created_at
    this.id = model.id
    this.image = model.image
    this.price = model.price
    this.sales_count = model.sales_count
    this.spu_id = model.spu_id
    this.status = model.status
    this.stock = model.stock
    this.version = model.version

  }
}





















