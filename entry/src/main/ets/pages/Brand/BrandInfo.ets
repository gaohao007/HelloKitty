import { GoodCard, NavBar } from '../../component';
import { APP_TOP_HEIGHT, BASE_URL } from '../../constans';
import { BrandItem, BrandItemModel, ProductItems, Products, ProductsModel, RouterTransmintParams } from '../../model';
import { router } from '@kit.ArkUI';
import { Log } from '@abner/log';
import { getBrandDatasProducts } from '../../Api/brand';

@Entry
@Component
struct BrandInfo {
  @State isShouCang:boolean = false
  @State brandInfo:BrandItem = new BrandItemModel({} as BrandItem)
  @State products:Products= new ProductsModel({} as Products)
  onPageShow() {
    const res = router.getParams() as RouterTransmintParams
    if (res && res.brandItem) {
      this.brandInfo = res.brandItem
    }
    if (res && res.brandItem) {
        this.getBrandProducts(res.brandItem.id)
    }
  }

 async  getBrandProducts(brandID:number){
    const res = await getBrandDatasProducts(brandID)
    this.products = new ProductsModel(res)
   Log.info(JSON.stringify(this.products))
 }

  build() {
    Column(){
      Row().width("100%")
      .height(AppStorage.get(APP_TOP_HEIGHT))
      .backgroundColor($r("app.color.white"))
      NavBar({title:"品牌介绍"})

        if(this.brandInfo.backimg !==""){
          Image(BASE_URL+"/"+this.brandInfo.backimg )
            .width('100%')
            .height(146)
            .borderRadius(6)
            .objectFit(ImageFit.Fill)
        }else{
          Image($r("app.media.logsjdsdsdafdss"))
            .width('100%')
            .height(146)
            .borderRadius(6)
            .objectFit(ImageFit.Fill)
        }

      Column(){
        Row({space:20}){
          Text(this.brandInfo.name)
            .fontSize(20)
            .fontColor($r("app.color.text_primary"))
          Image(BASE_URL+"/"+this.brandInfo.logo)
            .width(30).aspectRatio(1).objectFit(ImageFit.Fill)
        }.width('100%')

       Row(){
          Blank()
         Button(){
            Row({space:16}){
              Image(this.isShouCang?$r("app.media.yishoucang"):
              $r("app.media.meiyoushoucang"))
                .width(16).aspectRatio(1)
                .objectFit(ImageFit.Fill)
                .fillColor('#f32b80')
              Text(this.isShouCang?"已收藏":'收藏').fontColor(this.isShouCang?$r("app.color.white"):'#f32b80')
                .fontSize(12)
            }
         }.backgroundColor(this.isShouCang?'#f32b80':$r("app.color.white"))
         .type(ButtonType.Normal)
         .onClick(()=>{
           this.isShouCang = !this.isShouCang
         })

         .border({width:{bottom:1},color:$r("app.color.background_divider")})
         .borderRadius(16)
         .width(80)
         .height(43)

       }.width("100%")
       Text(this.brandInfo.story)
         .fontSize(14)
         .fontColor($r("app.color.text_secondary"))
         .textOverflow({overflow:TextOverflow.Ellipsis})
         .maxLines(3)
     }.width('100%')
     .margin({top:10})
      .height(160)
     .justifyContent(FlexAlign.SpaceEvenly)
     .alignItems(HorizontalAlign.Start)
      .padding({left:20,right:20})
      .backgroundColor($r("app.color.background_page")).borderRadius(20)

      Row(){
        Text("品牌产品")
          .fontSize(20)
          .fontWeight(600)
          .fontColor($r("app.color.white"))
          .backgroundColor('#f32b80')
          .padding({ top:10,right:24,left:24,bottom:10 })
          .borderRadius({topLeft:40,bottomRight:40})

      }.width('100%')
      .margin({top:20})
      .border({width:{bottom:2},color:'#f32b80'})
        List({space:5}){
          ForEach(this.products.items,(items:ProductItems,index:number)=>{
            ListItem(){
              GoodCard({products:items})
            }.backgroundColor($r("app.color.background_page"))
            .borderRadius(16)
            .clip(true)
          })
      }.width('100%')
        .backgroundColor($r("app.color.white"))
      .margin({top:20,bottom:30})
      .layoutWeight(1)



    }
    .height('100%')
    .width('100%')
    .padding({left:20,right:20})
  }
}