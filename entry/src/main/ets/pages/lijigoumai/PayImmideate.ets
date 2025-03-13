
import { AddressDialogSelect, NavBar, PayDialog } from '../../component'
import { APP_TOP_HEIGHT, BASE_URL } from '../../constans'
import {  AddressItems, AddressItemsModel,
  CartItems,
  CreateOrderFromCart,
  CreateOrderFromCartModel,
  CreateOrderImmideate,
  CreateOrderImmideateModel,
  OrderSuccessData,
  OrderSuccessDataModel,
  PayOrder,
  PayOrderModel,
  PaySuccessData,
  PaySuccessDataModel,
  RouterTransmintParams,
  SkuInfoDetail} from '../../model'
import { promptAction, router } from '@kit.ArkUI'
import { createOrderFromCart, createOrderImmideate, getSkuInfoDetail, paySuccess } from '../../Api/order'
import { PerferenceHelpe } from '../../utils'

@Entry
@Component
struct PayImmideate {

@State payMoney:number=0

  @State addressItems:AddressItems = new AddressItemsModel({} as AddressItems)
selectAddress:CustomDialogController = new CustomDialogController({
  builder:AddressDialogSelect({
    confrimCallback:(data:AddressItems)=>{
        this.addressItems = data
      this.selectAddress.close()
    }
  }),
  alignment:DialogAlignment.Bottom,
  customStyle:true,
  autoCancel:false
})
  @State orderImmideate:CreateOrderImmideate =
    new CreateOrderImmideateModel({} as CreateOrderImmideate)
  @State createOrder:CreateOrderFromCart  =new CreateOrderFromCartModel({} as CreateOrderFromCart)

  aboutToAppear(){
        const params = router.getParams() as RouterTransmintParams
        if (params && params.immideateOrder) {
           this.createOrder = new CreateOrderFromCartModel({} as CreateOrderFromCart)
           this.orderImmideate = params.immideateOrder
          this.getSkuDetai(params.immideateOrder.sku_id!)


        }
        if (params && params.totalprice) {
          this.totalPrice = params.totalprice
          this.payMoney = params.totalprice
        }

      if (params && params.cartOrder) {
        this.orderImmideate  = new CreateOrderImmideateModel({} as CreateOrderImmideate)
        this.createOrder = params.cartOrder


        if (this.createOrder.cart_items.length>0) {
          this.createOrder.cart_items.forEach((item:CartItems)=>{
            this.getSkuDetai(item.sku_id!)
          })
        }
      }
  }
//得到每一个sku信息
@State skuInfoList:SkuInfoDetail[]=[]
async getSkuDetai(id:number){
    const  res = await getSkuInfoDetail(id)
     this.skuInfoList.push(res)
}

  @State orderSuccess:OrderSuccessData= new OrderSuccessDataModel({} as OrderSuccessData)
  
  @State totalPrice:number=0
  @State payOrderAddressId :PayOrder = new PayOrderModel({} as PayOrder)


  @State paySuccessData:PaySuccessData = new PaySuccessDataModel({} as PaySuccessData)

  payDialog:CustomDialogController = new CustomDialogController({
    builder:PayDialog({
      totalPrice:this.payMoney,
    confrimCallback:async ()=>{
        const user_id =await new PerferenceHelpe(getContext(this)).getUserID()
        if (user_id !==0 && this.orderSuccess.order_id !==0  && this.addressItems.id !==0) {
              this.payOrderAddressId.address_id = this.addressItems.id
              const res = await paySuccess(this.payOrderAddressId,user_id,this.orderSuccess.order_id)
              this.paySuccessData = res

          console.log('------->?paySuccessData',JSON.stringify(this.paySuccessData))
          promptAction.showToast({message:"支付成功"})
          router.pushUrl({url:"pages/order/OrderPage"})
          this.payDialog.close()

      }else {
          promptAction.showToast({message:"请先登录"})
        }
    }
    }),
    alignment:DialogAlignment.Bottom,
    customStyle:true,
    autoCancel:false
  })




  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:"确认订单"})
      Image($r("app.media.paysh_001")).width('100%')
        .height(75)
        .objectFit(ImageFit.Fill)
        .margin({bottom:20})
      Column(){

        Row(){
          Column(){
            if (this.addressItems.name !== undefined){
             Row({space:5}){
               Text(this.addressItems.phone)
               Text(this.addressItems.name)
             }.width('100%')
             Text(){
               Span(this.addressItems.province+' ')
               Span(this.addressItems.city+' ')
               Span(this.addressItems.district+' ')
               Span(this.addressItems.detail)
             }.width('100%')
            }else {
              Text('收货地址')
                .fontSize(16)
                .fontColor($r("app.color.text_primary"))
                .fontWeight(600)
            }
          }
          Blank()
          Image($r("app.media.xiangyoujiantou"))
            .width(45)
            .aspectRatio(1)
            .onClick(()=>{
              this.selectAddress.open()
            })
        }.width('100%').height(60)
        .padding({left:20,right:20})
        .backgroundColor($r("app.color.white"))
        .borderRadius(12)

        Grid(){
            if (this.skuInfoList.length>0){
              ForEach(this.skuInfoList,(item:SkuInfoDetail)=>{
                GridItem(){
                  Row(){
                    Image(BASE_URL+"/"+item.spu.main_image).width(60).aspectRatio(1)
                      .objectFit(ImageFit.Fill).border({width:1,color:$r("app.color.background_divider")})
                      .shadow({radius:20})
                  }
                }
              })
              GridItem(){
                Text('共 '+this.skuInfoList.length+'件商品')
                  .fontColor($r("app.color.text_secondary"))
                  .fontSize(12)
              }
            }else {
              GridItem(){
                Text('暂无商品')
                  .fontSize(14)
                  .fontColor($r("app.color.text_secondary"))
              }
            }
        }.width('100%')
        .rowsTemplate('1fr')
        .columnsGap(20)
        .height(80)
        .padding({left:20,right:20})
        .backgroundColor($r("app.color.white"))
        .margin({top:20,bottom:20})
        .borderRadius(12)

        Row(){
          Text('配送')
          Blank()
          Text('预计明天可以发货')
            .fontSize(12)
            .fontColor($r("app.color.text_secondary"))
        }.width('100%')
        .borderRadius(12)
        .padding(20)
        .backgroundColor($r("app.color.white"))

        Column({space:15}){
          Row(){
            Text('商品金额')
            Blank()
            Text(){
              Span('￥').fontSize(12).fontColor('#f03867')
              Span(this.totalPrice.toFixed(2)).fontColor('#f03867')
                .fontSize(23).fontWeight(600)
            }
          }.width('100%')



          Row(){
            Text('预估总运费')
            Blank()
            Text('新人满38免运费')
              .fontSize(14).fontColor($r("app.color.text_secondary"))
          }.width('100%')

          Row(){
            Text('优惠券')
            Blank()
            Text('无可用优惠券')
              .fontSize(14).fontColor($r("app.color.text_secondary"))
          }.width('100%')

        }.width('100%')
        .padding(10).margin({top:20})
        .backgroundColor($r("app.color.white"))
        .borderRadius(12)


      }.padding({left:20,right:20})

      Row(){
        Text(){
          Span('实付')
          Span('￥').fontColor('#f03867')
            .fontSize(23).fontWeight(600)
          Span(this.totalPrice.toFixed(2)).fontColor('#f03867')
            .fontSize(23).fontWeight(600)

        }
        Blank()
        Button('提交订单')
          .backgroundColor('#f03867')
          .type(ButtonType.Normal)
          .width(120)
          .height(40)
          .borderRadius(10)
          .onClick(()=>{
            if (this.addressItems.name !== undefined) {
              if (this.orderImmideate.sku_id !== undefined
                && this.orderImmideate.sku_id !== null
                && this.orderImmideate.sku_id !== 0) {
                this.orderImmideate.address_id = this.addressItems.id
                this.immideateOrder()
                this.skuInfoList=[]
                this.totalPrice=0
              }else if (this.createOrder.cart_items !==undefined && this.createOrder.cart_items !== null && this.createOrder.cart_items.length>0){
                this.createOrder.address_id = this.addressItems.id
                this.createOrderFromCart()
                this.skuInfoList=[]
                this.totalPrice=0
              }
            }else {
              promptAction.showToast({message:"请选择收货地址"})
            }
          })
      }.width('100%').height(80)
      .padding({left:20,right:20})
      .position({bottom:0})
      .backgroundColor($r("app.color.white"))

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }

  async immideateOrder(){
    if (this.orderImmideate.user_id !== undefined
        && this.orderImmideate.sku_id !== undefined
        && this.orderImmideate.quantity !== undefined
        && this.orderImmideate.address_id !== undefined)
    {
      const res = await createOrderImmideate(this.orderImmideate)
      this.orderSuccess = res
      promptAction.showToast({message:"下单成功"})
      this.payDialog.open()
    }
  }

  async createOrderFromCart(){
    if (this.createOrder.user_id !== undefined
        && this.createOrder.cart_items !== undefined
        && this.createOrder.address_id !== undefined
    ) {
      const res = await createOrderFromCart(this.createOrder)
      this.orderSuccess = res
      this.payDialog.open()
      promptAction.showToast({message:"下单成功"})
    }
  }

}