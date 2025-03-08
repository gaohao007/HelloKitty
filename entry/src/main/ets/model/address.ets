


export interface AddressList{
  items: AddressItems[]
}
export class AddressListModel implements AddressList{
  items: AddressItems[]=[]
  constructor(data:AddressList){
    this.items = data.items
  }
}
export interface AddressItems{
  city: string
  created_at: string
  detail: string
  district: string
  id: number
  is_default: number
  name: string
  phone: string
  province: string
}
export class AddressItemsModel implements AddressItems{
  city: string=''
  created_at: string=''
  detail: string=''
  district: string=''
  id: number=0
  is_default: number=0
  name: string=''
  phone: string=''
  province: string=''

  constructor(model:AddressItems) {
    this.city = model.city
    this.created_at = model.created_at
    this.detail = model.detail
    this.district = model.district
    this.id = model.id
    this.is_default = model.is_default
    this.name = model.name
    this.phone = model.phone
    this.province = model.province
  }
}

//增加地址的参数
export interface AddAddressParams
{
name: string
phone: string
province: string
city: string
district: string
detail:string
is_default: boolean
}

export class AddAddressParamsModel implements AddAddressParams{
  name: string=''
  phone: string=''
  province: string=''
  city: string=''
  district: string=''
  detail:string=''
  is_default: boolean=false

  constructor(data:AddAddressParams) {
    this.name = data.name
    this.phone = data.phone
    this.province = data.province
    this.city = data.city
    this.district = data.district
    this.detail = data.detail
    this.is_default = data.is_default
  }
}

//接受地区的数据类型
export interface AddressAreaData{
  id: number
  name: string
  parent_id: number
}
export class AddressAreaDataModel implements AddressAreaData{
  id: number=0
  name: string=''
  parent_id: number=0
  constructor(data:AddressAreaData) {
    this.id = data.id
    this.name = data.name
    this.parent_id = data.parent_id
  }
}










































