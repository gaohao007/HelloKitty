import { Carousel, } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getCarouselData(){
  return await Request_API.get<Carousel[]>('api/carousel')
}