

export interface BrandItem{
  backimg:string
  id: number
  is_recommend: number
  logo: string
  name: string
  sort_order: number
  story: string
}

export  class BrandItemModel implements BrandItem{
  backimg: string =""
  id: number=0
  is_recommend: number=0
  logo: string =""
  name: string =""
  sort_order: number=0
  story: string =""

  constructor(data:BrandItem) {
    this.backimg = data.backimg
    this.id = data.id
    this.is_recommend = data.is_recommend
    this.logo = data.logo
    this.name = data.name
    this.sort_order = data.sort_order
    this.story = data.story
  }
}