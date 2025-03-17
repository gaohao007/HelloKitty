
import { cancleOrder, confrimShouhuo, deleteOrder, paySuccess, shipOrder, userOrders } from "../Api/order"
import { PayOrder, PayOrderModel, ProductItems, Products, UserOrderItems } from "../model"
import { PerferenceHelpe } from "../utils"
import { promptAction, router } from "@kit.ArkUI"
import { GoodCard, OrderItems, PayDialog } from "."
import { getRandomProducts } from "../Api"


@Component
export struct AllOrders{

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

  @State orderList:UserOrderItems[]=[]
  async getUserOrderList(){
    const user_id = await new PerferenceHelpe(getContext(this)).getUserID()
    if (user_id!==0) {
      const res = await userOrders(user_id)
      this.orderList = res.items
    }else {
      this.orderList=[]
      promptAction.showToast({message:"请先登录"})
      router.pushUrl({url:"pages/login/Login"})
    }
  }
  aboutToAppear(): void {
    this.getUserOrderList()
    this.getProducts()
  }


  //取消订单
  async  cancleOrder(userid:number,orderid:number){
    await cancleOrder(userid,orderid)
    promptAction.showToast({message:"取消成功"})
    this.getUserOrderList()
  }
  //支付订单
  @State userid:number=0
  @State orderid:number=0
  @State payData:PayOrder =new PayOrderModel({} as PayOrder)

  async payOrder(data:PayOrder,user_id:number,order_id:number){
    await paySuccess(data,user_id,order_id)
    promptAction.showToast({message:"支付成功"})
    this.getUserOrderList()
  }
  //催发货
  async shipOrders(user_id:number,order_id:number){
    await shipOrder(user_id,order_id)
    promptAction.showToast({message:"发货成功"})
    this.getUserOrderList()
  }
//删除订单
  async deleteOrderSomeone(user_id:number,order_id:number){
    await deleteOrder(user_id,order_id)
    promptAction.showToast({message:"删除成功"})
    this.getUserOrderList()
  }

  @State
  products:ProductItems[]=[]
  // 获取猜你喜欢的商品
  async  getProducts(){
    const res =await getRandomProducts() as Products
    this.products = res.items

  }
  // 确认收货
  async confrimshouhuo(user_id:number,order_id:number){
    await confrimShouhuo(user_id,order_id)
    promptAction.showToast({message:"确认收货成功"})
    this.getUserOrderList()
  }
  build() {
    Column(){
        List({space:10}){
          ListItem(){
            Row(){
              Blank()
              Image($r("app.media.shuaxin_000002")).aspectRatio(1).width(20)
                .onClick(()=>{
                  this.getUserOrderList()
                })
            }.width('100%')
          }
          if (this.orderList.length>0){
            ForEach(this.orderList,(item:UserOrderItems,index:number)=>{
              ListItem(){
                OrderItems({
                  orderItem:item,
                  cancleOrder:(user_id,order_id)=>{
                    this.cancleOrder(user_id,order_id)
                  },

                  goToPayOrder:(data:PayOrder,user_id:number,order_id:number)=>{
                    this.totalPrice = item.total_amount
                    this.payData =data
                    this.userid =user_id
                    this.orderid =order_id
                    this.payDialog.open()
                  },

                  shipOrder:(user_id,order_id)=>{
                    this.shipOrders(user_id,order_id)
                  },

                  deleteOrderSomeone:(user_id,order_id)=>{
                    this.deleteOrderSomeone(user_id,order_id)
                  },
                  confrimshouhuo:(user_id,order_id)=>{
                  this.confrimshouhuo(user_id,order_id)
                  },
                  remarkCallback:()=>{
                      router.pushUrl({url:"pages/remark/RemarkGoods",
                      params:{
                        userOrderItems:item
                      }
                      })
                  }
                })
              }.width('100%')
              .backgroundColor($r("app.color.white"))
              .borderRadius(18)
              .clip(true)
            })
          }
          else{
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
            ForEach(this.products,(productitem:ProductItems,index:number)=>{
              ListItem(){
                GoodCard({products:productitem})
              }
              .backgroundColor($r("app.color.white"))
              .borderRadius(10)
              .clip(true)
            })
          }
        }.width('100%')
        .margin({bottom:100})
      .scrollBar(BarState.Off)
    }.width('100%')
    .backgroundColor($r("app.color.background_page"))
    .padding(20)
    .height('100%')
  }
}