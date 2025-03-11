


export  interface UserCarts {
  items: CartItem[]
}

export class CartModel implements UserCarts {
  items: CartItem[]=[]
  constructor(model:UserCarts){
    this.items = model.items
  }
}

export interface CartItem{
  color: string
  selected: number
  id: number
  image: string
  price: number
  quantity: number
  size: string,
  sku_id: number
  spu_description: string
  spu_id: number
  spu_main_image:string
  spu_name:string
  stock:number
}
export class CartItemModel implements CartItem{
  id: number=0
  image: string=""
  price: number=0

  quantity: number=0
  sku_id: number=0
  spu_description: string=""
  selected: number=0

  spu_id: number=0
  spu_main_image:string=""
  spu_name:string=""

  size: string=""
  color: string=""

  stock: number=0
  constructor(model:CartItem){
    this.id = model.id
    this.image = model.image
    this.price = model.price
    this.quantity = model.quantity
    this.sku_id = model.sku_id
    this.spu_description = model.spu_description
    this.spu_id = model.spu_id
    this.spu_main_image = model.spu_main_image
    this.spu_name = model.spu_name
    this.size = model.size
    this.color = model.color
    this.selected = model.selected
    this.stock = model.stock
  }
}

export class  SelectOrCancleParams{
  selected:boolean =false
  constructor(selected:boolean){
    this.selected = selected
  }
}



export class UpdateCartquantity{
  quantity:number=0
  constructor(quantity:number){
    this.quantity = quantity
  }
}

//创建购物车
export interface  CreatCartParams{
  sku_id:number
  quantity:number
}

export class  CreatCartParamsModel implements CreatCartParams{
  sku_id:number=0
  quantity:number=0
  constructor(model:CreatCartParams){
    this.sku_id = model.sku_id
    this.quantity =model.quantity
  }
}


