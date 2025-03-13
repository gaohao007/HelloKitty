import { promptAction, router } from "@kit.ArkUI"


@Component
@CustomDialog
export struct PayDialog{
  customController:CustomDialogController
  @State totalPrice:number=0
  @State currentIndex:number=0
  @State isPay:boolean=false
  @State payList:PayMethodClass[]=[
    {
      icon:$r("app.media.pinduoduozhifu"),
      title:"多多支付"
    },
    {
      icon:$r("app.media.weixinzhifu"),
      title:"微信支付"
    },
    {
      icon:$r("app.media.xianyonghoufu"),
      title:"先用后付(0元下单)"
    },
    {
      icon:$r("app.media.zhifubaozhifu"),
      title:"支付宝"
    },
    {
      icon:$r("app.media.haoyouzhifu"),
      title:"找微信好友支付"
    },
    {
      icon:$r("app.media.qqqianbaozhifu"),
      title:"QQ钱包"
    },
    {
      icon:$r("app.media.huabei"),
      title:"花呗"
    }
  ]

  build() {
    Column({space:15}){
      Row(){
        Text('订单待支付').fontSize(18).fontColor($r("app.color.text_primary"))
          .fontWeight(600).margin({left:40})
        Blank()
        Image($r("app.media.chahao"))
          .width(20).aspectRatio(1).margin({right:20})
          .onClick(()=>{
            this.customController.close()
            router.pushUrl({url:"pages/order/OrderPage"})
          })
      }.width('100%')
      .border({width:{bottom:1},color:$r("app.color.background_divider")})
      List({space:10}){
          ForEach(this.payList,(items:PayMethodClass,index:number)=>{
            ListItem(){
                  Row({space:10}){
                    Image(items.icon).width(24).aspectRatio(1).objectFit(ImageFit.Fill)
                    Text(items.title)
                    Blank()
                    if (this.isPay && this.currentIndex ==index) {
                      Image($r("app.media.duigou")).width(24).aspectRatio(1)
                    }
                  }.width('100%')
                  .padding({left:20,right:20})
                  .backgroundColor((this.isPay && this.currentIndex ==index)?$r("app.color.background_page"):$r("app.color.white"))
                  .borderRadius(10)
                  .height(50)
                  .alignItems(VerticalAlign.Center)
              .onClick(()=>{
                this.isPay = ! this.isPay
                this.currentIndex = index
              })
            }.width('100%')
          })
        ListItem(){
            Row(){
              Button("马上支付"+this.totalPrice.toFixed(2)+"元")
                .type(ButtonType.Normal)
                .fontSize(21)
                .fontWeight(700)
                .borderRadius(10)
                .width('100%')
                .height(50)
                .backgroundColor('#f03867')
                .onClick(()=>{
                  if (this.isPay) {
                    this.confrimCallback()
                  }else {
                    promptAction.showToast({
                      message:"请选择支付方式",
                      duration:3000
                    })
                  }
                })
            }.width('100%')
        }
      }.width('100%')

    }.width('100%')
    .padding(20)
    .backgroundColor($r("app.color.white"))
    .height(600)
    .borderRadius({topLeft:10,topRight:10})
  }
  confrimCallback:()=>void = ()=>{}
}
class PayMethodClass{
  icon:ResourceStr=""
  title:string=""
}