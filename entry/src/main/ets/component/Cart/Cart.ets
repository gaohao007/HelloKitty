
import { deleteSomeOneCartItem, getCartData, isCancelOrSelect, updateCartQuantity } from "../../Api"
import { APP_TOP_HEIGHT, BASE_URL } from "../../constans"
import { CartItem, SelectOrCancleParams, UpdateCartquantity } from "../../model"
import { PerferenceHelpe } from "../../utils"
import { promptAction } from "@kit.ArkUI"

@Component
export struct Cart{
  @State user_id:number=0
  @State cartList:CartItem[]=[]
  //总金额
  @State totalPrice:number=0
  @State clickEditText:boolean=false
  //数量
  @State quantity:UpdateCartquantity=new UpdateCartquantity(0)
 async  aboutToAppear(){
    this.getUserID()
   if (this.user_id !==0) {
     this.cartList=[]
     const res = await getCartData(this.user_id)
     this.cartList = res.items
   }
  }
  async getUserID(){
    const user_id = await new PerferenceHelpe(getContext(this)).getUserID()
    this.user_id = user_id
    if (this.user_id!==0) {
         this.cartList=[]
        const res = await getCartData(this.user_id)
        this.cartList = res.items
       this.cartList.forEach((item)=>{
        if (item.selected ===1) {
          this.totalPrice += item.price*item.quantity
        }
      })
    }
  }
//获取价格
async getTotalPrice(){
   this.cartList =[]
    this.totalPrice=0
  if (this.user_id !==0) {
   const res =  await getCartData(this.user_id)
    this.cartList =res.items
    if (this.cartList.length>0) {
      this.cartList.forEach((item)=>{
        if (item.selected ===1) {
          this.totalPrice += item.price*item.quantity
        }
      })
    }
  }
}
@State changeStatus:ChangeCartSelectStatus[]=[]
//取消还是选择
 async changeSelectedStatus(){
   if (this.user_id !==0) {
      this.changeStatus.forEach(async (item)=>{
       await isCancelOrSelect(this.user_id,item.id,item.selected)
     })
     this.getTotalPrice()
   }
 }




  @Builder
  getCartCard(item:CartItem){
    Row(){
      Checkbox({name:item.sku_id.toString(),group:"cartGroup"}).width(20).aspectRatio(1)
        .margin({right:10})
        .select(item.selected===1)
        .onChange((value:boolean)=>{
                 const  obj = new ChangeCartSelectStatus()
                 obj.id =item.id
                 obj.selected = new SelectOrCancleParams(value)
                 this.changeStatus.push(obj)
              this.changeSelectedStatus()
        })
      Image(BASE_URL+"/"+item.spu_main_image).width(60).aspectRatio(1)
        .objectFit(ImageFit.Fill)
        .border({width:1,color:$r("app.color.background_divider")})
        .shadow({radius:20})
        .borderRadius(8)
      Column(){
        Text(item.spu_description).fontSize(12).fontColor($r("app.color.text_secondary"))
          .constraintSize({minWidth:0,maxWidth:160})
          .maxLines(2).textOverflow({overflow:TextOverflow.Ellipsis})
        Row(){
          Text(`¥${item.price.toFixed(2)}`).fontSize(18).fontWeight(700)
          Row(){
            Button('+')
              .backgroundColor($r("app.color.white")).height(25).width(40)
              .type(ButtonType.Normal).borderRadius({topLeft:6,bottomLeft:6})
              .fontColor($r("app.color.text_secondary"))
              .onClick(()=>{
                if (item.quantity<item.stock) {
                  item.quantity++
                  this.quantity.quantity = item.quantity
                  this.changeCartCount(item.id)
                }else{
                  promptAction.showToast({ message:"库存不足",duration:4000,alignment:Alignment.Center })
                  this.quantity.quantity = item.stock
                  this.changeCartCount(item.id)
                }
                this.getTotalPrice()
              })
            Text(item.quantity+'').fontColor($r("app.color.text_secondary")).width(40)
              .border({width:{left:1,right:1},color:$r("app.color.background_divider")})
              .textAlign(TextAlign.Center)
            Button('-')
              .backgroundColor($r("app.color.white")).height(25).width(40)
              .type(ButtonType.Normal)
              .borderRadius({topRight:6,bottomRight:6})
              .fontColor($r("app.color.text_secondary"))
              .onClick(()=>{
                if (item.quantity ==1) {
                  AlertDialog.show({
                    message:"确定删除该商品吗",
                    alignment:DialogAlignment.Center,
                    secondaryButton:{
                      value:"取消",
                      action:()=>{}
                    },
                    primaryButton:{
                      value:"确定",
                      action:()=>{
                        this.deleteSomeoneCartItem(item.id)
                        this.getTotalPrice()
                      }
                    }
                  })
                }else {
                 item.quantity--
                  this.quantity.quantity = item.quantity
                  this.changeCartCount(item.id)
                }
                this.getTotalPrice()
              })
          }.border({width:1,color:$r("app.color.background_divider")})
          .margin({left:20})
        }.width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({left:10})
    }.width('100%')
    .alignItems(VerticalAlign.Center)
  }
  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
      Text('购物车')
        .fontSize(24)
        .fontWeight(700)
        .width('100%')
        .fontColor($r("app.color.white"))
        .padding({left:20})
      Row(){
        Text(`共${this.cartList.length}件商品`)
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r("app.color.white"))
        Blank()
        Text('编辑')
          .fontSize(14)
          .fontColor($r("app.color.white"))
          .onClick(() => {
            this.clickEditText= !this.clickEditText
          })
      }.width('100%')
      .padding({left:20,right:20})
      .margin({top:20})
      Scroll(){
        Column({space:20}){
            if (this.cartList.length>0){
              ForEach(this.cartList,(item:CartItem)=>{
                this.getCartCard(item)
              })
            }else{
              Image($r("app.media.kongdegouwuche"))
                .width(120).aspectRatio(1)
                .objectFit(ImageFit.Fill)
              Text('购物车空空如也').fontSize(18).fontColor($r("app.color.text_secondary"))

            }

        }.width('100%')
        .height(600)
        .padding({left:20,right:20,top:20,bottom:20})
        .alignItems(HorizontalAlign.Start)
      }.width('100%')
      .margin({left:20,right:20,top:20,bottom:80})
      .layoutWeight(1)
      .borderRadius(12)
      .backgroundColor($r("app.color.white"))
      .scrollBar(BarState.Off)
     Row({space:5}){
        CheckboxGroup({group:"cartGroup"}).width(20)
          .aspectRatio(1)
          .onChange((value)=>{
          })
       Text('全选')
       Blank()
       if (!this.clickEditText){
         Text(){
           Span('合计: ').fontColor($r("app.color.text_secondary")).fontSize(12)
           Span('¥').fontSize(12)
           Span(this.totalPrice.toFixed(2)).fontSize(16).fontWeight(500)
         }
       }
       Button(this.clickEditText?"删除":'去结算')
         .height(48)
         .width(120)
         .backgroundColor($r("app.color.primary"))
         .type(ButtonType.Normal)
         .borderRadius(10)
         .onClick(()=>{
           if (this.clickEditText){
             AlertDialog.show({
               message:"确定删除这些选中的商品吗?",
               alignment:DialogAlignment.Center,
               primaryButton:{
                 value:"确定",
                 action:()=>{
                   this.cartList.forEach( (item)=>{
                     if (item.selected ===1) {
                       this.deleteSomeoneCartItem(item.id)
                       this.getTotalPrice()
                     }
                   })
                 }
                 ,backgroundColor:$r("app.color.primary")
               },
               secondaryButton:{
                 value:"取消",
                 action:()=>{}
               }
             })
           }else{

           }
         })
     }
     .width('100%')
      .height(60)
      .padding({left:20,right:20})
      .position({
        bottom:0
      })
      .backgroundColor($r("app.color.white"))
      .border({width:1,color:$r("app.color.background_divider")})
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction:GradientDirection.Bottom,
      colors:[[0XCCCCCC,0.0],[0Xcccccc,0.3],[0xf2f2f2,0.3],[0xf2f2f2,1.0]] })
  }
// 删除某个商品
async  deleteSomeoneCartItem(itemId:number){
 await deleteSomeOneCartItem(this.user_id,itemId)

}
// 修改购物车数量
async changeCartCount(cart_id:number){
    await updateCartQuantity(this.user_id,cart_id,this.quantity)
    this.cartList=[]
    const res = await getCartData(this.user_id)
    this.cartList = res.items
}
}
class ChangeCartSelectStatus{
  id:number=0
  selected:SelectOrCancleParams = new SelectOrCancleParams(false)
}
