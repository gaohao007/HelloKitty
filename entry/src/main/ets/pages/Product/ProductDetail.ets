import { NavBar } from '../../component'
import {  APP_TOP_HEIGHT, BASE_URL } from '../../constans'
import { promptAction, router } from '@kit.ArkUI'
import {
  CreatCartParams,
  CreatCartParamsModel,
  CreateOrderImmideate,
  CreateOrderImmideateModel,
  ProductColors,
  ProductColorsModel,
  ProductDetailData, ProductDetailDataModel,
  remarkItem,
  RouterTransmintParams,

  Sizes,
  SizesModel,
  SkuInfo,
  SkuInfoModel} from '../../model'
import {
  createCartItems,
  getColorsSpu, getProductRemarks, getSizeData, getSizes, getSkuInfo, spu_info } from '../../Api'
import { Log } from '@abner/log'
import { PerferenceHelpe } from '../../utils'

@Entry
@Component
struct ProductDetail {

  //直接生成订单
  @State createOrderImmideate:CreateOrderImmideate =
    new CreateOrderImmideateModel({} as CreateOrderImmideate)


  @State imgUrl:string = BASE_URL+"/"
  @State spu_id:number=0
  //价格
  @State price:number=0
  //选择中的小图片
  @State selectIndex:number=0
  //小图中的数组
  @State imgList:string[]=[]
  // 是否收藏
  @State isShoucang:boolean=false
  //颜色被选中,默认第一个颜色被选中
  @State colorCurrentIndex:number=0
  @State isSelectColor:boolean=true
  //尺寸选择下标
  @State sizeCurrentIndex:number=0
  @State isSelectSize:boolean=true


  @State sizeStr:string=""
  @State colorStr:string=""

@State
 colors:ProductColors =new ProductColorsModel({} as ProductColors)

  @State
   spuDetailData : ProductDetailData = new ProductDetailDataModel({} as ProductDetailData)
  async aboutToAppear(){
    const res =router.getParams() as RouterTransmintParams
    if (res && res.id) {
      this.spu_id = res.id
      this.spuDetailData = await spu_info(res.id)
      this.imgUrl = this.imgUrl+this.spuDetailData.detail_images[0]
      this.imgList = this.spuDetailData.detail_images
      this.price = this.spuDetailData.skus[0].price
      const result = await getColorsSpu(res.id)
      this.colors = result
      this.colorStr = this.colors.colors[this.colorCurrentIndex]
      this.getProductsRemark()

    }
    console.log('---->     this.colorStr = this.colors.colors[this.colorCurrentIndex]',JSON.stringify(this.colorStr))
      await this.getSizeDatas()
       if (this.colorStr && this.sizeStr) {
           this.getSkuInfo()
 }
  }

  //
  async ChangeImage(color:string){
    if (this.spu_id && color) {
      this.imgList=[]
      const res = await getSizeData(this.spu_id,color)
      this.imgList = res.images
      this.imgUrl =BASE_URL+"/"+res.images[0]
    }
  }
  @State sizes:Sizes = new SizesModel({} as Sizes)

  async getSizeDatas(){
    if (this.spu_id) {
      const res = await getSizes(this.spu_id)
      this.sizes = res
      this.sizeStr = this.sizes.sizes[this.sizeCurrentIndex]
    }
  }

  @State
  skuInfo:SkuInfo | null=new SkuInfoModel({} as SkuInfo)
@State totalPrice:number=0
 async getSkuInfo(){
   if (this.spu_id && this.sizeStr && this.colorStr) {
     const res = await getSkuInfo(this.spu_id,this.colorStr,this.sizeStr)
     this.skuInfo = res
     Log.info(JSON.stringify(res))
     this.totalPrice = 0
     this.totalPrice = res.price * this.count
   }
 }
@State count:number=1
//评论
@State remarks:remarkItem[]=[]

 
async getProductsRemark(){
  if (this.spu_id) {
    const res = await getProductRemarks(this.spu_id)
    this.remarks = res.items
    Log.info(JSON.stringify(this.remarks))
  }
} 
user_id:number=0
//创建购物车
@State createCartParams:CreatCartParams = new CreatCartParamsModel({} as CreatCartParams)

async createCart(){
  const userid = await new PerferenceHelpe(getContext(this)).getUserID()
  this.user_id = userid
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
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
         NavBar({title:"商品详情"})

    Stack({alignContent:Alignment.BottomEnd}){
      Column(){
        Image(this.imgUrl).width('90%')
          .margin(20)
          .height(190).backgroundColor('#00ffff')
          .objectFit(ImageFit.Fill)
          .border({width:1,color:$r('app.color.background_divider')})
          .shadow({radius:20})
          .borderRadius(12)
      }
      Image(this.isShoucang?$r("app.media.shoucang_111111"):$r("app.media.weishoucang_111111"))
        .width(60).height(40)
        .objectFit(ImageFit.Fill)
        .margin({right:30,bottom:30})
        .onClick(()=>{
          this.isShoucang = ! this.isShoucang
        })

    }

    Scroll(){
       Column(){
         Grid(){
           ForEach(this.imgList,(items:string,index:number)=>{
             GridItem(){
               Image(BASE_URL+"/"+items).aspectRatio(1)
                 .width(76)
                 .objectFit(ImageFit.Fill)
                 .border({width:this.selectIndex==index?2:1,color:this.selectIndex==index?$r('app.color.primary'):$r('app.color.background_divider')})
                 .borderRadius(10)
             }
             .onClick(()=>{
               this.selectIndex = index
               this.imgUrl =BASE_URL+"/"+items
             })
             .height(100)
             .width(100)
             .backgroundColor($r('app.color.white'))
             .borderRadius(12)
           })
         }
         .scrollBar(BarState.Off)
         .height(100)
         .width('100%')
         .padding({left:20,right:20})
         .rowsTemplate('1fr')
         .columnsGap(20)
         .margin({top:20})
         Column(){
            Text(this.spuDetailData.brand_name)
              .fontColor('#1e8eff')
              .width('100%')
              .margin({left:20,top:20})
           Row(){
              Text('唯品自营')
                .backgroundColor('#f33969')
                .fontColor($r('app.color.white'))
                .margin({right:10})
            Column(){
              Text(this.spuDetailData.description)
                .fontSize(18)
                .fontWeight(600)
                .maxLines(3)
                .textOverflow({overflow:TextOverflow.Ellipsis})
            }.layoutWeight(1)
           }.width('100%')
           .alignItems(VerticalAlign.Top)
           .margin({top:20,right:20,left:20})
           .padding({right:10})

           Row({space:10}){
              Text('￥').fontSize(20)
                .fontWeight(600)
                .fontColor($r('app.color.white'))
             Text(this.price.toFixed(2))
               .fontSize(30)
               .fontWeight(800)
               .fontColor($r('app.color.white'))
           }.width('100%')
           .padding({left:20})
           .height(80)
           .backgroundImage($r("app.media.backImgshhh"))
           .backgroundImageSize(ImageSize.FILL)
           .margin(20)
          Row(){
              Text('运费').fontSize(14).fontColor($r('app.color.text_secondary'))
              Text('新会员专享首单满38元免邮（限唯品自营商品，部分商品不可用）')
               .fontSize(14).margin({left:20})
          }.width('100%')
           .alignItems(VerticalAlign.Top)
          .margin({right:20})

           Row(){
              Text('颜色')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .margin({right:20})
              ForEach(this.colors.colors,(items:string,index:number)=>{
                  Text(items)
                    .width(80)
                    .height(40)
                    .backgroundColor($r('app.color.background_page'))
                    .margin({ left: 20 })
                    .textAlign(TextAlign.Center)
                    .backgroundImage((this.colorCurrentIndex===index && this.isSelectColor)
                      ?$r('app.media.xuanzhong_00001'):$r('app.media.weixuanzhong_00002'))
                    .backgroundImageSize(ImageSize.FILL)
                    .onClick(()=>{
                      this.isSelectColor = !this.isSelectColor
                      this.colorCurrentIndex = index
                      this.colorStr=""
                      this.ChangeImage(items)
                      if (this.isSelectColor && this.colorCurrentIndex ===index) {
                          this.colorStr = items
                      }
                      this.getSkuInfo()
                    })
              })
           }.width('100%').margin({top:20})

           Flex({direction:FlexDirection.Row,wrap:FlexWrap.Wrap,alignContent:FlexAlign.SpaceAround,justifyContent:FlexAlign.Start}){

                Text('尺寸')  .fontSize(14).fontColor($r('app.color.text_secondary')).margin({right:20})
                ForEach(this.sizes.sizes, (item: string, index: number) => {
                  Text(item).width(80).height(40).margin({ left: 10 })
                    .backgroundColor($r('app.color.background_page'))
                    .textAlign(TextAlign.Center)
                    .backgroundImage((this.sizeCurrentIndex===index && this.isSelectSize)
                      ?$r('app.media.xuanzhong_00001'):$r('app.media.weixuanzhong_00002'))
                    .backgroundImageSize(ImageSize.FILL)
                    .onClick(async ()=>{
                      this.isSelectSize = !this.isSelectSize
                      this.sizeCurrentIndex = index
                      this.sizeStr=""
                      if (this.isSelectSize && this.sizeCurrentIndex ===index) {
                          this.sizeStr = item
                      }
                          this.getSkuInfo()
                    })
                })
           }.width('100%').margin({top:20})
           .height(120)


           Row(){
              Text('数量').fontSize(14).fontColor($r('app.color.text_secondary')).margin({right:20})
              Row(){
                Button('-')
                  .backgroundColor($r('app.color.background_page')).height(40).width(50)
                  .type(ButtonType.Normal)
                  .fontSize(20)
                  .fontColor($r('app.color.text_primary'))
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
                Text(this.count+'').height(40).width(60)
                  .textAlign(TextAlign.Center)
                  .border({width:{left:1,right:1},color:$r('app.color.background_divider')})
                Button('+').height(40).width(50)
                  .fontSize(20)
                  .fontColor($r('app.color.text_primary'))
                  .type(ButtonType.Normal)
                  .backgroundColor($r('app.color.background_page'))
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
                            promptAction.showToast({message:"没有该件的库存"})
                          }
                        }
                      }else{
                        promptAction.showToast({message:"没有该件的库存"})
                      }
                    }else {
                      promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                    }
                  })
              }.border({width:1,color:$r('app.color.text_primary'),radius:6})
             .clip(true)
           }.width('100%').margin({top:20})


          Divider().strokeWidth(2)
            .color($r('app.color.background_divider'))
            .margin({top:20,bottom:20})


           Column({space:10}){
            Row({}){
              Text('该商品所属评价')
              Text(`(${this.remarks.length})`)
              Blank()
              Text('查看全部 >')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
            }.width('100%')
             ForEach(this.remarks,(items:remarkItem)=>{
               Column({space:10}){
                 Row({space:10}){
                   Image(BASE_URL+"/"+items.avatar).width(24).aspectRatio(1)
                     .objectFit(ImageFit.Fill)
                   Text(items.username)
                   Blank()
                   Text(items.rate+"星好评")
                     .fontSize(14)
                     .fontColor($r('app.color.text_secondary'))
                 }.width('100%')
                 Text(items.content)
                   .fontSize(15)
                   .fontColor($r('app.color.text_primary'))
                   .width('100%')
                   .textIndent(20)
               }.width('100%')
             })
           }.width('100%').margin({top:20})

         }.padding({left:20,right:20})
       }.width('100%')
        .height(1280)
      }.width('100%')
      .margin({bottom:80})
      .backgroundColor($r('app.color.white'))
      .borderRadius({topLeft:20,topRight:20})

   Row(){
          Row(){
            Column({space:3}){
              Image($r("app.media.dianpu")).aspectRatio(1)
                .width(24)
              Text('店铺').fontSize(12)
            }

            Column({space:3}){
              Image($r("app.media.fenxiang")).aspectRatio(1)
                .width(24)
              Text('分享').fontSize(12)
            }
            Column({space:3}){
              Image($r("app.media.gouwuche_3453")).aspectRatio(1)
                .width(24)
              Text('购物车').fontSize(12)
            }
            .onClick(()=>{
              router.pushUrl({url:'pages/Index'})
            })
          }.width('40%')

          .justifyContent(FlexAlign.SpaceAround)
          Row(){
            Button('加入购物车')
              .type(ButtonType.Normal)
              .width('50%')
              .backgroundColor($r('app.color.primary_disabled'))
              .borderRadius({topLeft:10,bottomLeft:10})
              .onClick(()=>{
                if (this.sizeStr && this.colorStr && this.createCartParams) {
                  this.createCart()
                  promptAction.showToast({message:"加入购物车成功",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                }else{
                  promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                }
              })
            Button('立即购买')
              .type(ButtonType.Normal)
              .backgroundColor($r('app.color.primary'))
              .width('50%')
              .borderRadius({topRight:10,bottomRight:10})
              .onClick(async ()=>{
                if (this.sizeStr && this.colorStr) {
                  if (this.skuInfo) {
                    this.createOrderImmideate.sku_id = this.skuInfo.id
                    this.createOrderImmideate.quantity = this.count
                   const user_id =  await new PerferenceHelpe(getContext(this)).getUserID()
                  this.createOrderImmideate.user_id = user_id
                    this.totalPrice = this.skuInfo.price * this.count
                  }
                  router.pushUrl({
                    url:"pages/lijigoumai/PayImmideate",
                    params:{
                      immideateOrder:this.createOrderImmideate,
                      totalprice:this.totalPrice
                    }
                  })
                }else {
                  promptAction.showToast({message:"请选择尺寸和颜色",duration:2000,alignment:Alignment.Center,textColor:"#f03867"})
                }
              })
          }.width('60%')
      }.width('100%')
      .height(120)
        .padding({left:10,right:10})
        .backgroundColor($r('app.color.white'))
        .position({bottom:0})
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }

}