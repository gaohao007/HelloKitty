

//接受广告请求接口数据
export interface AdvertiseData{
  isshow: boolean,
  showTime: number
  items:Advertiseitem[]
}

export interface Advertiseitem{
  description:string
  id: number
  image: string
}

export class AdvertiseDataModel implements AdvertiseData{
  isshow: boolean=true
  showTime: number=0
  items:Advertiseitem[]=[]
  constructor(model:AdvertiseData) {
    this.showTime = model.showTime
    this.isshow = model.isshow
    this.items = model.items
  }
}

export class AdvertiseitemModel implements Advertiseitem{
  description:string=''
  id: number=0
  image: string=''

  constructor(model:Advertiseitem) {
    this.description = model.description
    this.id = model.id
    this.image = model.image
  }
}

