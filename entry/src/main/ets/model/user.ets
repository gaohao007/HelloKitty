

export interface UserInfo{
  avatar: string
  created_at: string
  gender:string
  id: number
  is_deleted: number
  last_login: string
  phone:string
  status: number
  updated_at: string
  username: string
  addresses:Addssitems[]
}

export class UserInfoModel implements UserInfo{
  avatar: string =""
  created_at: string =""
  gender:string =""
  id: number =0
  is_deleted: number =0
  last_login: string =""
  phone:string =""
  status: number=0
  updated_at: string =""
  username: string =""
  addresses:Addssitems[]=[]
  constructor(data:UserInfo){
    this.avatar = data.avatar
    this.created_at = data.created_at
    this.gender = data.gender
    this.id = data.id
    this.is_deleted = data.is_deleted
    this.last_login = data.last_login
    this.phone = data.phone
    this.status = data.status
    this.updated_at = data.updated_at
    this.username = data.username
    this.addresses = data.addresses
  }
}


export interface Addssitems{
  created_at: string
  full_address: string
  id: number
  is_default:boolean
  name: string
  phone:string
}

export class addssitemsModels implements Addssitems{
  created_at: string =""
  full_address: string =""
  id: number =0
  is_default:boolean =false
  name: string =""
  phone:string =""
  constructor(data:Addssitems){
    this.created_at = data.created_at
    this.full_address = data.full_address
    this.id = data.id
    this.is_default = data.is_default
    this.name = data.name
    this.phone = data.phone
  }
}