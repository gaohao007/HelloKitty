
import { getRandomProducts } from "../../Api/products"
import { ProductItems, Products, TabClass } from "../../model"
import { Log } from "@abner/log"
import { GoodCard } from ".."


@Preview
@Component
export struct Mine{

  @State tabsData:TabClass[]=[
    {
      title:"待收款",
      name:"IS_NO_PAY",
      icon:$r("app.media.no_pay")
    },

    {
      title:"打包中",
      name:"packing",
      icon:$r("app.media.packing")
    },
    {
      title:"待收货",
      name:"daishouhuo",
      icon:$r("app.media.daishouhuo")
    },

    {
      title:"评价",
      name:"pinjia",
      icon:$r("app.media.pinjia")
    },
  ]

  @State orrtabsData:TabClass[]=[
    {
      title:"商品收藏",
      name:"shoucang",
      icon:$r("app.media.shoucang")
    },

    {
      title:"钱包",
      name:"qianbao",
      icon:$r("app.media.qianbao")
    },
    {
      title:"历史浏览",
      name:"lishi",
      icon:$r("app.media.liulanjilu")
    },

    {
      title:"退款售后",
      name:"tuikuan",
      icon:$r("app.media.tuikuan")
    },
  ]

  @State
    products:ProductItems[]=[]
    aboutToAppear() {
     this.getProducts()

  }

  aboutToDisappear() {
        this.products = []
  }
  // 获取猜你喜欢的商品
  async  getProducts(){
    const res =await getRandomProducts() as Products
    this.products = res.items
    Log.info(JSON.stringify(this.products))
  }



  @Builder
  displayIcon(){
    Row({}){
      Row({space:10}){
        Image($r("app.media.touxiang"))
          .width(30)
          .aspectRatio(1)
          .borderRadius(13)
        Column(){
          Text('未登录/请登录')
            .fontSize(20)
            .fontWeight(600)
          Row({space:10}){
            Image($r("app.media.local_fill"))
              .width(15).aspectRatio(1)
              .fillColor($r("app.color.text_secondary"))

            Text('收货地址 >')
              .fontSize(12)
              .fontColor($r("app.color.text_secondary"))
          }

        }
        .alignItems(HorizontalAlign.Start)
      }


      Button(){
        Row({space:10}){
          Image($r("app.media.setting"))
            .width(18).aspectRatio(1)
            .fillColor($r('app.color.text_secondary'))
          Text('设置')
            .fontColor(14)
            .fontColor($r("app.color.text_secondary"))
        }
      }.backgroundColor($r("app.color.white"))
      .width(80)
      .height(35)
      .border({width:1,color:$r("app.color.text_secondary")})
    }.width("100%")
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.SpaceBetween)

  }

  @Builder
  orderStaus(item:TabClass){
    Column({space:5}){
      Image(item.icon)
        .width(24).aspectRatio(1)
      Text(item.title)
    }
  }

  build() {
    Column({space:10}){
      this.displayIcon()
     Row(){
        Text('我的订单').fontSize(18)
          .fontWeight(600)
       Text('查看全部 >' )
         .fontColor($r("app.color.text_secondary"))
         .fontSize(14)
     }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({top:15,bottom:15})
    Row(){
        ForEach(this.tabsData,(items:TabClass)=>{
          this.orderStaus(items)
        })
    }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(6)
        .width('100%')
        .margin({bottom:15})

      Row(){
        ForEach(this.orrtabsData,(items:TabClass)=>{
          this.orderStaus(items)
        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(6)
        .width('100%')
    Text('猜你喜欢 ❤').width('100%')
      .margin({top:10})
      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(4)
      List(){
        ForEach(this.products,(items:ProductItems,index:number)=>{
          GoodCard({products:items})
        })
      }.width('100%')
      .layoutWeight(1)

    }.height('100%')
    .padding({left:20,right:20,top:15})
  }
}