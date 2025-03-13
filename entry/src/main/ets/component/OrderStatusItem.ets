
import { BASE_URL } from "../constans";
import { OrderStatusInfoItems, OrderStatusInfoItemsModel, PayOrder, PayOrderModel, Sku_items } from "../model";
import { PerferenceHelpe } from "../utils";
import { promptAction, router } from "@kit.ArkUI";


@Component
export struct OrderStatusItemCard{
  @State orderStatusItems:OrderStatusInfoItems = new OrderStatusInfoItemsModel({} as OrderStatusInfoItems)
  @State skuitems:Sku_items []=[]

  @State payOrderData:PayOrder = new PayOrderModel({} as PayOrder)
  aboutToAppear() {
    this.skuitems = this.orderStatusItems.items
    if (this.orderStatusItems.address && this.orderStatusItems.address.address_id !==0) {
        this.payOrderData.address_id = this.orderStatusItems.address.address_id
    }
  }

  build() {
    Column({space:10}){
       ForEach(this.skuitems,(item:Sku_items)=>{
         Row({space:10}){
           Image(BASE_URL+'/'+item.spu_main_image)
             .width(60).aspectRatio(1)
             .objectFit(ImageFit.Fill)
             .border({width:1,color:$r("app.color.background_divider"),radius:6})
             .shadow({radius:20})
           Column({space:8}){
             Text(item.spu_description)
               .maxLines(2)
               .textOverflow({overflow:TextOverflow.Ellipsis})
               .fontSize(14)
               .fontWeight(500)
               .constraintSize({minWidth:60,maxWidth:160})
             Text(){
               Span('￥').fontSize(12).fontColor('#f03867')
                 .fontWeight(500)
               Span(item.price.toFixed(2))
                 .fontSize(18).fontColor('#f03867')
                 .fontWeight(700)
             }
           }.alignItems(HorizontalAlign.Start)
           Text('数量x'+item.quantity)
             .fontSize(12)
             .fontColor($r("app.color.text_secondary"))
         }.width('100%')
       })
      Row(){
         Blank()
        Text(){
           Span('应付:  ').fontWeight(500)
          Span('￥').fontSize(12).fontWeight(500)
          Span(this.orderStatusItems.total_amount.toFixed(2))
            .fontSize(18).fontWeight(700)
            .fontColor('#f03867')
        }
      }.width('100%')
      .margin({top:10,bottom:18})

      if (this.orderStatusItems.status ==1){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id !==0 && this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })


          Button('去支付')
            .type(ButtonType.Normal)
            .width(80).height(45)
            .fontColor($r("app.color.white"))
            .fontWeight(600)
            .backgroundColor($r("app.color.primary"))
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.address && this.orderStatusItems.id ) {
                this.payOrderData.address_id = this.orderStatusItems.address.address_id
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.goToPayOrder(this.payOrderData,user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })

        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderStatusItems.status ==2){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id !==0 && this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })

          Button('催发货')
            .type(ButtonType.Normal)
            .width(80).height(45)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .backgroundColor($r("app.color.white"))
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.shipOrder(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }

            })

        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderStatusItems.status ==3){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id !==0 && this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })

          Button('确认收货')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .backgroundColor($r("app.color.white"))
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.confrimshouhuo(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }

            })


        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderStatusItems.status ==4){
        Row({space:10}){
          Blank()
          Button('删除订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderStatusItems.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.deleteOrderSomeone(user_id,this.orderStatusItems.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })

          Button('去评价')
            .type(ButtonType.Normal)
            .width(80).height(45)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .backgroundColor($r("app.color.white"))
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }


    }.width('100%')
    .padding(20)
    .backgroundColor($r("app.color.white"))
    .borderRadius(10)
  }
  //取消订单
  cancleOrder:(userid:number,orderid:number)=>void=()=>{}
  //去支付
  goToPayOrder:(payOrder:PayOrder,userid:number,orderid:number)=>void=()=>{}
  //催发货
  shipOrder:(userid:number,orderid:number)=>void=()=>{}
  //确认收货
  confrimshouhuo:(userid:number,orderid:number)=>void=()=>{}
  //删除订单
  deleteOrderSomeone:(userid:number,orderid:number)=>void=()=>{}
}