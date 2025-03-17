import { getCarouselData, getHotProducts, getJiageProducts, getSalesCountProducts, getZongheProducts } from "../../Api"
import { getBrandDatas } from "../../Api/brand"
import { APP_TOP_HEIGHT, BASE_URL } from "../../constans"
import { BrandItem, Carousel, ListDataSource, ProductItems, ProductRankItems } from "../../model"
import { router } from "@kit.ArkUI"
import { Log } from "@abner/log"
import { GoodsCard } from "../GoodCarsTwo"
import { ProductRankCard } from "../ProductRankCard"

@Preview
@Component

export struct Home{

  lazyDataSource:ListDataSource = new ListDataSource()

  @State zonghe:boolean=true
  @State jiage:boolean=false
  @State xiaoliang:boolean=false


  @State carousel:Carousel[]=[]
  @State brandList:BrandItem[]=[]
  @State isHotProducts:ProductItems[]=[]

  @State
  @Watch("updateDataSource")
  productRankItem:ProductRankItems[]=[]
  updateDataSource(){
    this.lazyDataSource.reloadData(this.productRankItem)
  }

 async  aboutToAppear() {
    this.getCarouselData()
    this.getBrands()
    this.getHotProducts()
    await  this.getProductRank()
    this.updateDataSource()
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
  }
  //综合排序
  async getProductRank(){
    const res = await getZongheProducts()
    this.productRankItem=[]
    this.productRankItem = res.items
  }
//价格排序
  async getJiageRank(){
    const res =await getJiageProducts()
    this.productRankItem=[]
    this.productRankItem=res.items
  }
  // 销量排序
async getXiaoLiangRank(){
     const res =  await getSalesCountProducts()
    this.productRankItem=[]
    this.productRankItem=res.items
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
        .onClick(()=>{
          router.pushUrl({url:"pages/search/searchPage"})
        })

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
          .scrollBar(BarState.Off)

          Row(){
            Text('综合')
              .fontSize((this.zonghe && ! this.jiage && !this.xiaoliang)?18:16)
              .fontWeight((this.zonghe && ! this.jiage && !this.xiaoliang)?700:500)
              .fontColor((this.zonghe && ! this.jiage && !this.xiaoliang)?$r("app.color.primary"):$r("app.color.text_primary"))
              .onClick(()=>{
                this.zonghe = true
                this.jiage=false
                this.xiaoliang = false
                this.getProductRank()
              })
            Text('价格')
              .fontWeight((!this.zonghe &&  this.jiage && !this.xiaoliang)?700:500)
              .fontSize((!this.zonghe && this.jiage && !this.xiaoliang)?18:16)
              .fontColor((!this.zonghe && this.jiage && !this.xiaoliang)?$r("app.color.primary"):$r("app.color.text_primary"))
              .onClick(()=>{
                this.zonghe = false
                this.jiage =true
                this.xiaoliang = false
                this.getXiaoLiangRank()
              })
            Text('销量')
              .fontWeight((!this.zonghe && ! this.jiage && this.xiaoliang)?700:500)
              .fontSize((!this.zonghe && ! this.jiage && this.xiaoliang)?18:16)
              .fontColor((!this.zonghe && ! this.jiage && this.xiaoliang)?$r("app.color.primary"):$r("app.color.text_primary"))
              .onClick(()=>{
                this.zonghe = false
                this.jiage =false
                this.xiaoliang =true
                this.getXiaoLiangRank()
              })
          }.width('100%')
          .margin({left:30,right:30,top:20,bottom:20})
          .borderRadius(6)
          .padding(5)
          .justifyContent(FlexAlign.SpaceAround)
          .backgroundColor($r("app.color.background_page"))


          Grid(){
            LazyForEach(this.lazyDataSource,(items:ProductRankItems,index:number)=>{
              GridItem(){
                ProductRankCard({productRankItem:items})
              }.width('100%')
              .height(130)
              .padding({top:5,bottom:5})
              .backgroundColor($r("app.color.background_page"))
              .borderRadius(10)
            })
          }.cachedCount(4)
          .columnsTemplate("1fr")
          .rowsGap(20)
          .width('100%')
        }

}.layoutWeight(1)
      .scrollBar(BarState.Off)
      .margin({bottom:20})





    }.width('100%')
    .height('100%')
    .padding({left:20,right:20})
  }
}