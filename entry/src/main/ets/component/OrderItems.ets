import { BASE_URL } from "../constans";
import { PayOrder,
  PayOrderModel,
  UserOrderItems, UserOrderItemsItems, UserOrderItemsItemsModel, UserOrderItemsModel } from "../model";
import { PerferenceHelpe } from "../utils";
import { promptAction, router } from "@kit.ArkUI";


@Component
export struct OrderItems{

  @State orderItem:UserOrderItems = new UserOrderItemsModel({} as UserOrderItems)
  @State userSkuItems:UserOrderItemsItems[] =[]
  aboutToAppear() {
    this.userSkuItems = this.orderItem.items
    console.log('------->orderItem',JSON.stringify(this.orderItem));
  }

  @State payOrder:PayOrder = new PayOrderModel({} as PayOrder)


  build() {
    Column({space:10}){
        Row(){
          Blank()
          Text(this.getStringfromStatus(this.orderItem.status))
        }.width('100%').padding({right:20,top:20})
      ForEach(this.userSkuItems,(items:UserOrderItemsItems)=>{
        Row({space:15}){
            Image(BASE_URL+"/"+items.spu_main_image)
              .aspectRatio(1).width(60)
              .objectFit(ImageFit.Fill)
              .border({width:1,color:$r("app.color.background_divider")})
              .shadow({radius:20})
          Column({space:5}){
              Text(items.spu_description)
                .fontSize(14)
                .maxLines(2)
                .textOverflow({overflow:TextOverflow.Ellipsis})
                .constraintSize({minWidth:60,maxWidth:180})
            Text(){
                Span("￥").fontSize(12).fontColor('#f03867')
                Span(items.price.toFixed(2)).fontColor('#f03867')
                .fontSize(18).fontWeight(700)
            }

          }.alignItems(HorizontalAlign.Start)
          Blank()
          Text('数量X'+items.quantity)
            .fontSize(12).fontColor($r("app.color.text_secondary"))
        }.width("100%")
        .padding({left:20,right:20})
        .margin({top:10,right:10})
      })

        Row(){
          Blank()
          Text(){
            Span('应付:').fontSize(14).fontWeight(600)
            Span('￥').fontSize(12).fontWeight(600)
              .fontWeight(700)
            Span(this.orderItem.total_amount.toFixed(2))
              .fontSize(18).fontColor('#f03867')
              .fontWeight(700)
          }
        }.width('100%').padding({left:20,right:20})

      if (this.orderItem.status ==1){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontSize(18)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderItem.id)
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
              if (this.orderItem.address_id && this.orderItem.id) {
                this.payOrder.address_id = this.orderItem.address_id
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.goToPayOrder(this.payOrder,user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }

              }
                  
            })
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderItem.status ==2){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontSize(18)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderItem.id)
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
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                   this.shipOrder(user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }

            })
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderItem.status ==3){
        Row({space:10}){
          Blank()
          Button('取消订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontSize(18)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.cancleOrder(user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }

            })

          Button('确认收货')
            .type(ButtonType.Normal)
            .width(80).height(45)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .backgroundColor($r("app.color.white"))
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.confrimshouhuo(user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }

            })
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderItem.status ==4){
        Row({space:10}){
          Blank()
          Button('删除订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontSize(18)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.deleteOrderSomeone(user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })

          Button('待评价')
            .type(ButtonType.Normal)
            .width(80).height(45)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .backgroundColor($r("app.color.white"))
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(()=>{
                this.remarkCallback()
            })
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }

      if (this.orderItem.status ==5){
        Row({space:10}){
          Blank()
          Button('删除订单')
            .type(ButtonType.Normal)
            .width(110).height(45)
            .fontSize(18)
            .backgroundColor($r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
            .border({width:1,color:$r("app.color.background_divider")})
            .borderRadius(6)
            .onClick(async ()=>{
              if (this.orderItem.id) {
                const user_id =await  new PerferenceHelpe(getContext(this)).getUserID()
                if (user_id !==0) {
                  this.deleteOrderSomeone(user_id,this.orderItem.id)
                }else {
                  promptAction.showToast({message:'请先登录'})
                  router.pushUrl({url:'pages/login/Login'})
                }
              }
            })
        }.width("100%")
        .padding({left:20,right:20,bottom:20})
      }


    }.width('100%')
    .backgroundColor($r("app.color.white"))
  }


  getStringfromStatus(status:number):string{
    if (status ===1) {
      return "待支付"
    }
    if (status ==2) {
      return "待发货"
    }
    if (status ==3) {
      return "待收货"
    }
    if (status ==4) {
      return "待评价"
    }
    if (status ===5) {
      return "已取消"
    }
    return "已完成"
  }
//quxiao
   cancleOrder:(userid:number,orderid:number)=>void=()=>{}
  //支付
  goToPayOrder:(data:PayOrder,userid:number,orderid:number)=>void=()=>{}
  //催发货
  shipOrder:(userid:number,orderid:number)=>void=()=>{}
  //删除订单
  deleteOrderSomeone:(userid:number,orderid:number)=>void=()=>{}
  //确认收货
  confrimshouhuo:(userid:number,orderid:number)=>void=()=>{}
  //评价
  remarkCallback:()=>void=()=>{}
}