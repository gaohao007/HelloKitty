

export interface Remarks{
  items:remarkItem[]
}
export class RemarksModel implements Remarks{
  items:remarkItem[]=[]
  constructor(remarks:Remarks){
    this.items = remarks.items
  }
}



export interface remarkItem{
  avatar: string
  content: string
  created_at: string
  id: number
  is_anonymous: number
  rate: number
  username: string
}

export  class remarkItemModel implements remarkItem{
  avatar: string=''
  content: string=''
  created_at: string=''
  id: number=0
  is_anonymous: number=0
  rate: number=0
  username: string=''

  constructor(data:remarkItem) {
    this.avatar = data.avatar
    this.content = data.content
    this.created_at = data.created_at
    this.id = data.id
    this.is_anonymous = data.is_anonymous
    this.rate = data.rate
    this.username = data.username
  }
}

//发表评价
export interface CreateRemark{
  content: string
  rate: number
}

export class CreateRemarkModel implements CreateRemark{
  content: string=''
  rate: number=0
  constructor(data:CreateRemark){
    this.content = data.content
    this.rate = data.rate
  }
}


export interface RemarkContens{
  items:Remark_items[]
}
export class RemarkContensModel implements RemarkContens{
  items:Remark_items[]=[]
  constructor(data:RemarkContens){
    this.items = data.items
  }
}


export interface Remark_items{
  avatar: string
  content: string
  created_at:string
  id: number
  is_anonymous: boolean
  rate: number
  spu: SpuInfoItem|null
  spu_id: number
  username: string
}
export class Remark_itemsModel implements Remark_items{
  avatar: string=''
  content: string=''
  created_at:string=''
  id: number=0
  is_anonymous: boolean=false
  rate: number=0
  spu: SpuInfoItem |null =null
  spu_id: number=0
  username: string=''
  constructor(data:Remark_items){
    this.avatar = data.avatar
    this.content = data.content
    this.created_at = data.created_at
    this.id = data.id
    this.is_anonymous = data.is_anonymous
    this.rate = data.rate
    this.spu =data.spu
    this.spu_id = data.spu_id
    this.username = data.username
  }
}


export interface SpuInfoItem{
  brand_id: number
  category_id: number
  description: string
  id: number
  main_image:string
  name:string
}

export class SpuInfoItemModel implements SpuInfoItem{
  brand_id: number=0
  category_id: number=0
  description: string=''
  id: number=0
  main_image:string=''
  name:string=''
  constructor(data:SpuInfoItem){
    this.brand_id = data.brand_id
    this.category_id = data.category_id
    this.description = data.description
    this.id = data.id
    this.main_image = data.main_image
    this.name = data.name
  }
}















































