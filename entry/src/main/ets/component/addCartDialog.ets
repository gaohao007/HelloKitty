import { Log } from "@abner/log"
import { createCartItems, getColorsSpu, getSizes, getSkuInfo, spu_info } from "../Api"
import { BASE_URL } from "../constans"
import {
  CreatCartParams,
  CreatCartParamsModel,
  ProductColors, ProductColorsModel, ProductDetailData, ProductDetailDataModel, Sizes,
  SizesModel,
  SkuInfo,
  SkuInfoModel} from "../model"
import { promptAction, router } from "@kit.ArkUI"
import { PerferenceHelpe } from "../utils"

@Component
@CustomDialog
export struct  AddCartDialog{
  customController:CustomDialogController
  @State spu_id:number=0

  @State sizeStr:string=""
  @State colorStr:string=""


  //颜色被选中,默认第一个颜色被选中
  @State colorCurrentIndex:number=0
  @State isSelectColor:boolean=false
  //尺寸选择下标
  @State sizeCurrentIndex:number=0
  @State isSelectSize:boolean=false




  @State
  skuInfo:SkuInfo | null=new SkuInfoModel({} as SkuInfo)

  async getSkuInfo(){
    if (this.spu_id && this.sizeStr && this.colorStr) {
      const res = await getSkuInfo(this.spu_id,this.colorStr,this.sizeStr)
      this.skuInfo = res
      Log.info(JSON.stringify(res))
    }
  }


//spu详细
  @State
  spuDetailData : ProductDetailData = new ProductDetailDataModel({} as ProductDetailData)
 //  颜色详细
  @State
  colors:ProductColors =new ProductColorsModel({} as ProductColors)
  //价格
  @State price:number=0
  //数量
  @State count:number=1

 async  aboutToAppear() {
    if (this.spu_id !==0) {
      this.spuDetailData = await spu_info(this.spu_id)
      this.price = this.spuDetailData.skus[0].price
      const result = await getColorsSpu(this.spu_id)
      this.colors = result
      this.getSizeDatas()
    }
  }

  @State sizes:Sizes = new SizesModel({} as Sizes)
  async getSizeDatas(){
    if (this.spu_id) {
      const res = await getSizes(this.spu_id)
      this.sizes = res
    }
  }


  //创建购物车
  @State createCartParams:CreatCartParams = new CreatCartParamsModel({} as CreatCartParams)

  async createCart(){
    const userid = await new PerferenceHelpe(getContext(this)).getUserID()
    if (userid ==0){
      promptAction.showToast({message:'请先登录'})
      router.pushUrl({url:"pages/login/Login"})
      return
    }
    if ( this.spu_id && this.skuInfo ) {
      this.createCartParams.sku_id = this.skuInfo.id
      this.createCartParams.quantity = this.count
      await createCartItems(userid,this.createCartParams)
    }
  }

  build() {
    Column({space:20}){
      Row({space:15}){
        Image(BASE_URL+"/"+this.spuDetailData.main_image)
          .aspectRatio(1).width(60).objectFit(ImageFit.Fill)
          .border({width:1,color:$r("app.color.border")})
          .shadow({radius:20})
        Column(){
          Text(this.spuDetailData.description)
            .fontSize(14)
            .maxLines(2)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .constraintSize({minWidth:100,maxWidth:220})
          Text(){
            Span('￥').fontSize(12).fontColor('#f33969').margin({right:10})
            Span(this.price.toFixed(2)).fontSize(18).fontWeight(700).fontColor('#f33969')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
      }.width('100%')
      Text('颜色').fontWeight(600).width('100%')
      Flex({direction:FlexDirection.Row,wrap:FlexWrap.Wrap,alignContent:FlexAlign.SpaceBetween}){
            ForEach(this.colors.colors,(item:string,index:number)=>{
              Text(item).width(80).height(40).margin({left:13})
                .textAlign(TextAlign.Center)
                .backgroundImage((this.colorCurrentIndex===index && this.isSelectColor)
                  ?$r('app.media.xuanzhong_00001'):$r('app.media.weixuanzhong_00002'))
                .backgroundImageSize(ImageSize.FILL)
                .onClick(()=>{
                  this.isSelectColor = !this.isSelectColor
                  this.colorCurrentIndex = index
                  this.colorStr=""
                  if (this.isSelectColor && this.colorCurrentIndex ===index) {
                    this.colorStr = item
                  }
                  this.getSkuInfo()
                })
            })

      }.width('100%')
      .height(100)


      Text('尺码').fontWeight(600).width('100%')

      Flex({direction:FlexDirection.Row,wrap:FlexWrap.Wrap,alignContent:FlexAlign.SpaceBetween}){
        ForEach(this.sizes.sizes,(item:string,index:number)=>{
          Text(item).width(80).height(40).margin({left:13})
            .textAlign(TextAlign.Center)
            .backgroundImage((this.sizeCurrentIndex===index && this.isSelectSize)
              ?$r('app.media.xuanzhong_00001'):$r('app.media.weixuanzhong_00002'))
            .backgroundImageSize(ImageSize.FILL)
            .onClick(()=>{
              this.isSelectSize = !this.isSelectSize
              this.sizeCurrentIndex = index
              this.sizeStr=""
              if (this.isSelectSize && this.sizeCurrentIndex ===index) {
                this.sizeStr = item
              }
              this.getSkuInfo()
            })
        })

      }.width('100%')
      .height(100)

      Row(){
        Text('数量').fontWeight(700)
        Blank()
        Row(){
          Button('-').width(60).height(40)
            .type(ButtonType.Normal)
            .backgroundColor($r("app.color.background_page"))
            .fontSize(18)
            .fontColor($r("app.color.text_primary"))
            .onClick(()=>{
              if (this.sizeStr && this.colorStr) {
                this.count--
                if (this.count<=1) {
                  this.count=1
                  promptAction.showToast({message:"本商品一件起售",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                }
              }else{
                promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
              }
            })


          Text(this.count+'').width(100).height(40).backgroundColor($r("app.color.white"))
            .textAlign(TextAlign.Center).fontWeight(700)
            .fontSize(20)
          Button('+').width(60).height(40)
            .type(ButtonType.Normal)
            .backgroundColor($r("app.color.background_page"))
            .fontSize(18)
            .fontColor($r("app.color.text_primary"))
            .onClick(()=>{
              if (this.sizeStr && this.colorStr) {
                if (this.skuInfo) {
                  if (this.skuInfo.stock ===0) {
                    promptAction.showToast({message:"没有该件的库存"})
                  }else {
                    if (this.count <= this.skuInfo.stock) {
                      this.count++
                    }else {
                      this.count = this.skuInfo.stock
                      promptAction.showToast({message:"该件的库存不足"})
                    }
                  }
                }else{
                  promptAction.showToast({message:"没有该件的库存"})
                }
              }else {
                promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
              }
            })


        }.border({width:2,color:$r("app.color.background_divider"),radius:10})
      }.width('100%')

      Row(){
        Button('取消').width('50%')
          .height(40).type(ButtonType.Normal)
          .fontSize(22).fontColor($r("app.color.white"))
          .backgroundColor('#f688a4')
          .onClick(()=>{
            this.customController.close()
          })
        Button('确定').width('50%')
          .height(40).type(ButtonType.Normal)
          .fontSize(22).fontColor($r("app.color.white"))
          .backgroundColor('#f03867')
          .onClick(()=>{

              if (this.sizeStr && this.colorStr && this.createCartParams) {
                console.log('-ds-d-sd-s-ds-ds-d-',JSON.stringify(this.createCartParams))
                this.createCart()
                promptAction.showToast({message:"加入购物车成功",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                this.customController.close()
              }else{
                promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
              }
          })
      }.width('100%')
      .borderRadius(12).clip(true)
    }
    .width('100%')
    .height(600)
    .backgroundColor($r("app.color.white"))
    .borderRadius({topLeft:20,topRight:20})
    .padding(20)

  }
}













