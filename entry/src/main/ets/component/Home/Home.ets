import { getCarouselData, getHotProducts } from "../../Api"
import { getBrandDatas } from "../../Api/brand"
import { APP_TOP_HEIGHT, BASE_URL } from "../../constans"
import { BrandItem, Carousel, ProductItems } from "../../model"
import { router } from "@kit.ArkUI"
import { Log } from "@abner/log"
import { GoodsCard } from "../GoodCarsTwo"

@Preview
@Component

export struct Home{

  @State carousel:Carousel[]=[]
  @State brandList:BrandItem[]=[]
  @State isHotProducts:ProductItems[]=[]
  aboutToAppear() {
    this.getCarouselData()
    this.getBrands()
    this.getHotProducts()
  }
  async getCarouselData(){
    const  res = await getCarouselData()
    this.carousel = res
  }
  async getBrands(){
    const res = await getBrandDatas()
    this.brandList = res
  }

  async getHotProducts(){
    const res = await getHotProducts()
    this.isHotProducts = res.items
    Log.info(JSON.stringify(this.isHotProducts))
  }

  scroller: Scroller = new Scroller()
  build() {
    Column({space:5}){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      Text('Swikily的店铺')
        .letterSpacing(2)
        .fontSize(26)
        .fontWeight(600)
        .width("100%")
      Search({placeholder:"想要找什么商品呢?"})

      Scroll(this.scroller){
        Column(){
          Swiper(){
            ForEach(this.carousel,(item:Carousel,index:number)=>{
              Image(BASE_URL+"/"+item.image_url)
                .width('100%')
                .height('100%')
                .borderRadius(10)
                .objectFit(ImageFit.Fill)
            })
          }.autoPlay(true)
          .width('100%')
          .height(132)
          .borderRadius(10)
          .indicator(false)

          Grid(this.scroller){
            ForEach(this.brandList,(items:BrandItem)=>{
              GridItem(){
                Column({space:3}){
                  Image(BASE_URL+"/"+items.logo)
                    .width(36).aspectRatio(1)
                    .borderRadius(18)
                    .objectFit(ImageFit.Fill)
                  Text(items.name).fontSize(14)
                    .fontColor($r("app.color.text_secondary"))
                }.padding({top:5,bottom:5})
              }.width(80).height(80)
              .onClick(()=>{
                router.pushUrl({url:`pages/Brand/BrandInfo`,
                  params:{
                    brandItem:items
                  }
                })
              })
              .borderRadius(6)
              .backgroundColor($r("app.color.background_page"))
            })
          }
          .width('100%')
          .height(160)
          .margin({top:20})
          .columnsGap(10)
          .rowsGap(5)
          .rowsTemplate("1fr 1fr")
          .scrollBar(BarState.Off)

          Text('热销')
            .fontSize(20)
            .fontWeight(600)
            .width('100%')
            .margin({top:10})
          Text('更多 >')
            .width('100%')
            .fontSize(12)
            .fontColor($r("app.color.text_secondary"))
            .textAlign(TextAlign.End)
          Grid(){
            ForEach(this.isHotProducts,(items:ProductItems,index:number)=>{
              GridItem(){
                GoodsCard({products:items})
              }.width(130)
              .height(180)
              .borderRadius(10)
              .backgroundColor($r("app.color.background_page"))
            })
          }.rowsTemplate("1fr")
          .columnsGap(20)
          .width('100%')
          .height(180)
          .margin({top:10})

        }

}





    }.width('100%')
    .height('100%')
    .padding({left:20,right:20})
  }
}