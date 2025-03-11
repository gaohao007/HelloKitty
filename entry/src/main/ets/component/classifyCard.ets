import { Log } from "@abner/log"
import { it } from "@ohos/hypium"
import { getCategoryData } from "../Api"
import { BASE_URL } from "../constans"
import { Category, CategoryModel, ProductItems } from "../model"
import { router } from "@kit.ArkUI"
import { AddCartDialog } from "./addCartDialog"


@Component
export struct ClassifyCard{

  @State categoryItem:Category = new CategoryModel({} as Category)
  @State productList:ProductItems[]=[]

  async aboutToAppear() {
    if (this.categoryItem) {
      const res = await getCategoryData(this.categoryItem.id)
      this.productList =res.items
      Log.info(JSON.stringify(this.productList))
    }
  }
@State sid:number=0
  @Builder
  getProductCard(item:ProductItems){
    Row({space:5}){
      Image(BASE_URL+"/"+item.main_image)
        .border({width:1,color:$r("app.color.background_divider")})
        .shadow({radius:20})
        .aspectRatio(1)
        .width(60)
        .objectFit(ImageFit.Fill)
        .borderRadius(6)
        .clip(true)
      Column({space:5}){
        Text(item.description)
          .constraintSize({minWidth:0,maxWidth:120})
          .fontSize(12)
          .maxLines(3)
          .textOverflow({overflow:TextOverflow.Ellipsis})
        Text(item.category_name)
          .padding(6)
          .fontSize(14)
          .borderRadius(4)
          .fontColor($r("app.color.primary"))
          .backgroundColor($r("app.color.white"))
          .fontWeight(600)
        Row({space:40}){
          Text(){
            Span('￥').fontSize(12).fontWeight(500)
            Span(item.skus[0].price.toFixed(2))
              .fontSize(16)
              .fontWeight(700)
              .fontColor('#f32b80')
          }
          Image($r("app.media.gouwuche2")).width(20).aspectRatio(1)
            .onClick(()=>{
              this.sid = item.id
              this.cartDialog.open()
            })
        }

      }.layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

    }.width('100%')
    .margin({left:10,right:10})
  }

  cartDialog:CustomDialogController = new CustomDialogController({
    builder:AddCartDialog({spu_id:this.sid}),
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    autoCancel:false
  })



  build() {
      List({space:18}){
        ForEach(this.productList,(item:ProductItems,index:number)=>{
          ListItem(){
              this.getProductCard(item)
          }.backgroundColor($r("app.color.background_page"))
          .onClick(()=>{
            router.pushUrl({url:"pages/Product/ProductDetail",
              params:{id:item.id}
            })
          })
          .width('100%')
          .borderRadius(6)
          .padding(5)

        })
        ListItem(){
          Text('已经到底了!')
            .fontSize(12)
            .fontColor($r("app.color.text_secondary"))
        }.width('100%')
        .padding(10)
      }.width('100%')
    .height('100%')
    .padding({top:10,right:10,bottom:10,left:10})
    .margin({top:20,bottom:30})
  }
}