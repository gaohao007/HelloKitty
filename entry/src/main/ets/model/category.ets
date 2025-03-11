

export interface  Category{
  id:number
  image:string
  name: string
  parent_id: number
  sort_order: number
  children?: Category[],
}

export class CategoryModel implements Category{
  id:number=0
  image:string=""
  name: string=""
  parent_id: number=0
  sort_order: number=0
  children?: Category[]=[]
  constructor(category:Category){
    this.id=category.id
    this.image=category.image
    this.name=category.name
    this.parent_id=category.parent_id
    this.sort_order=category.sort_order
    this.children=category.children
  }
}
