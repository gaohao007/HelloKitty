

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






















































