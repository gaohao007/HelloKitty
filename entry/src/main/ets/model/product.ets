

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