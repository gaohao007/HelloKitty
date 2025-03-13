import { NavBar } from '../../component';
import { APP_TOP_HEIGHT, BASE_URL } from '../../constans';
import { CreateRemark, CreateRemarkModel, RouterTransmintParams, UserOrderItems } from '../../model';
import { promptAction, router } from '@kit.ArkUI';
import { PerferenceHelpe } from '../../utils';
import { createRemark } from '../../Api';

@Entry
@Component
struct RemarkGoods {
  @State userOrderItems:UserOrderItems | null =null
  aboutToAppear() {
    const params = router.getParams() as RouterTransmintParams
    if (params && params.userOrderItems) {
      this.userOrderItems = params.userOrderItems
      console.log('userOrderItems',JSON.stringify(params.userOrderItems))
    }
  }

  @State rateNumber:number = 0
  @State createRemarkParams:CreateRemark = new CreateRemarkModel({} as CreateRemark)

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:'发表评价'})

      Column(){
        Row(){
          Image(BASE_URL+'/'+this.userOrderItems?.items[0].spu_main_image)
            .aspectRatio(1).width(30).objectFit(ImageFit.Fill)
            .border({width:1,color:$r("app.color.background_divider")})
          Text('综合评分')
          Rating({rating:this.rateNumber,indicator:false})
            .stars(5)
            .stepSize(1)
            .margin({left:10})
            .onChange((value)=>{
              this.rateNumber = value
              if (this.rateNumber !==0) {
                this.createRemarkParams.rate = this.rateNumber
              }else {
                promptAction.showToast({message:"请选择评分"})
              }
            })
          Text(this.getStr())
            .fontSize(14).fontColor($r("app.color.text_secondary"))
            .margin({left:10})
        }.width('100%')
      }.width('100%')
      .margin({top:20})
      .backgroundColor($r("app.color.white"))
      .padding(20)
      .border({width: { bottom:1 },color:$r("app.color.background_divider")})

      TextArea({placeholder:"多多描述商品和使用的感受,更受欢迎哦"}).width('100%')
        .height(100).backgroundColor($r("app.color.white")).padding(10)
        .borderRadius(0)
        .onChange((value:string)=>{
          if (value !=="") {
            this.createRemarkParams.content = value
          }else{
            promptAction.showToast({message:"请输入评价内容"})
          }
        })

      Row(){
        Button('发表评价').width('100%').height(60)
          .backgroundColor($r("app.color.primary"))
          .type(ButtonType.Normal)
          .borderRadius(10)
          .fontSize(18)
          .fontWeight(500)
          .onClick(async ()=>{
              const user_id = await new PerferenceHelpe(getContext(this)).getUserID()
            if (user_id !==0) {
              if (this.userOrderItems && this.createRemarkParams) {
                await createRemark(this.userOrderItems.items[0].sku_id,user_id,this.createRemarkParams)
                promptAction.showToast({message:"发表成功"})
                router.back()
              }
            }else {
              promptAction.showToast({message:"请先登录"})
              router.pushUrl({url:"pages/login/Login"})
            }
          })

      }.width('100%')
      .margin({top:20})
      .padding({left:20,right:20})
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
  getStr(){
    if (this.rateNumber==1) {
      return '差'
    }
    if (this.rateNumber==2) {
      return '较差'
    }
    if (this.rateNumber==3) {
      return '一般'
    }
    if (this.rateNumber==4) {
      return '好'
    }
    if (this.rateNumber==5) {
      return '非常好'
    }
    return ''
  }
}