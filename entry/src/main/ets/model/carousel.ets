
export interface Carousel{
  description: string,
  id: number,
  image_url: string,
  title: string
}

export  class CarouselModel implements Carousel{
  description: string
  id: number
  image_url: string
  title: string
  constructor(data:Carousel){
    this.description = data.description
    this.id = data.id
    this.image_url = data.image_url
    this.title = data.title
  }
}