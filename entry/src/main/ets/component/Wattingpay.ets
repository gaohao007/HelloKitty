import { GoodCard, OrderStatusItemCard, PayDialog } from "."
import { getRandomProducts } from "../Api"
import { cancleOrder, confrimShouhuo, deleteOrder, differentOrderStatus, paySuccess, shipOrder } from "../Api/order"
import { OrderStatusInfoItems, PayOrder, PayOrderModel, ProductItems, Products } from "../model"
import { PerferenceHelpe } from "../utils"
import { promptAction } from "@kit.ArkUI"


@Component
export struct Wattingpay{

  //支付订单
  @State userid:number=0
  @State orderid:number=0
  @State payData:PayOrder =new PayOrderModel({} as PayOrder)
  @State totalPrice:number=0
  payDialog:CustomDialogController =new CustomDialogController({
    builder:PayDialog({totalPrice:this.totalPrice,
      confrimCallback:()=>{
        if (this.userid !==0 && this.orderid !==0 && this.payData) {
          this.payOrder(this.payData,this.userid,this.orderid)
          this.payDialog.close()
        }
      }
    }),
    autoCancel:false,
    alignment:DialogAlignment.Bottom,
    customStyle:true
  })


  @State status:number=0

   aboutToAppear() {
   this.getStatusOrder()
    this.getProducts()
  }
  @State orderStatusItems:OrderStatusInfoItems[]=[]

  async getStatusOrder(){
    this.orderStatusItems = []
    const user_id  =await new PerferenceHelpe(getContext(this)).getUserID()
    if (user_id !==0 && this.status !==0) {
      const res = await differentOrderStatus(user_id,this.status)
      this.orderStatusItems = res.orders
    }
  }

  @State
  products:ProductItems[]=[]
  // 获取猜你喜欢的商品
  async  getProducts(){
    const res =await getRandomProducts() as Products
    this.products = res.items

  }

  // 点击取消订单
  async cancleOrder(userid:number,orderId:number){
      await cancleOrder(userid,orderId)
      this.getStatusOrder()
  }
//支付成功
  async payOrder(data:PayOrder,user_id:number,order_id:number){
    await paySuccess(data,user_id,order_id)
    promptAction.showToast({message:"支付成功"})
    this.getStatusOrder()
  }

  //催发货
  async shipOrders(user_id:number,order_id:number){
    await shipOrder(user_id,order_id)
    promptAction.showToast({message:"发货成功"})
    this.getStatusOrder()
  }

  // 确认收货
  async confrimshouhuo(user_id:number,order_id:number){
    await confrimShouhuo(user_id,order_id)
    promptAction.showToast({message:"确认收货成功"})
    this.getStatusOrder()
  }
  //删除订单
  async deleteOrderSomeone(user_id:number,order_id:number){
    await deleteOrder(user_id,order_id)
    promptAction.showToast({message:"删除成功"})
    this.getStatusOrder()
  }


  build() {
    Column(){
      List({space:10}){
        ListItem(){
          Row(){
            Blank()
            Image($r("app.media.shuaxin_000002")).aspectRatio(1).width(20)
              .onClick(()=>{
                this.getStatusOrder()
              })
          }.width('100%')
        }
        if (this.orderStatusItems.length>0){
              ForEach(this.orderStatusItems,(item:OrderStatusInfoItems)=>{
                ListItem(){
                  OrderStatusItemCard({
                    orderStatusItems:item,
                    cancleOrder:(userid:number,orderId:number)=>{
                      this.cancleOrder(userid,orderId)
                    },
                    goToPayOrder:(data:PayOrder,userid:number,orderId:number)=>{
                              this.totalPrice = item.total_amount
                              this.payData =data
                              this.userid =userid
                              this.orderid =orderId
                              this.payDialog.open()
                    },
                    shipOrder:(user_id,order_id)=>{
                      this.shipOrders(user_id,order_id)
                    },
                    confrimshouhuo:(user_id,order_id)=>{
                      this.confrimshouhuo(user_id,order_id)
                    },
                    deleteOrderSomeone:(user_id,order_id)=>{
                      this.deleteOrderSomeone(user_id,order_id)
                    },


                  })
                }.width('100%')
              })
        }
        else {
          ListItem(){
            Row(){
              Text('暂无订单')
                .fontSize(30)
                .fontColor($r("app.color.text_secondary"))
            }.width('100%')
            .justifyContent(FlexAlign.Center)
          }
          ListItem(){
            Row(){
              Text('猜你喜欢 ❤')
              Row({space:5}){
                Image($r("app.media.shuaxin")).height(20).aspectRatio(1)
                Text('刷新一下')
                  .fontColor($r("app.color.text_secondary"))
                  .fontSize(14)
              }
              .onClick(async ()=>{
                this.products=[]
                await this.getProducts()
              })
            }.width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({top:10})
          }
          ForEach(this.products,(productitem:ProductItems)=>{
            ListItem(){
              GoodCard({products:productitem})
            }
            .backgroundColor($r("app.color.white"))
            .borderRadius(10)
            .clip(true)
          })
        }
      }.width('100%')
      .margin({bottom:120})
      .scrollBar(BarState.Off)
    }.width('100%')
    .height('100%')
    .padding(20)
  }
}