import { BASE_URL } from "../constans"
import { ProductRankItems,ProductRankItemsModel } from "../model"
import { router } from "@kit.ArkUI"
import { AddCartDialog } from "./addCartDialog"


@Component
export  struct ProductRankCard{
  @State
  productRankItem:ProductRankItems= new ProductRankItemsModel({} as ProductRankItems)

  cartDialog:CustomDialogController = new CustomDialogController({
    builder:AddCartDialog({spu_id:this.productRankItem.spu_id}),
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    autoCancel:false
  })

  build() {
    Row({space:10}){
      Image(BASE_URL+"/"+this.productRankItem.spu_main_image)
        .width(80).aspectRatio(1)
        .objectFit(ImageFit.Fill)
        .border({width:1,color:$r("app.color.background_divider")})
        .shadow({radius:20})
        .borderRadius(10)
        .clip(true)
      Column({space:5}){
        Text(this.productRankItem.spu_description)
        .fontSize(14)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(300)
        Text(this.productRankItem.category_name)
          .padding(10)
          .borderRadius(4)
          .backgroundColor($r("app.color.white"))
        Row({space:10}){
          Text(){
            Span('￥').fontSize(14).fontWeight(600)
              .fontColor('#f32b80')
            Span(this.productRankItem.avg_price.toFixed(2))
              .fontSize(20)
              .fontWeight(600)
              .fontColor('#f32b80')
          }
          Blank()
          Image($r("app.media.cart_12221332"))
            .width(20)
            .aspectRatio(1)
            .onClick(()=>{
              this.cartDialog.open()
            })
        }.width('100%')
        .padding({right:20})
      }.layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }.width('100%')
    .height(120)
    .padding({left:20,right:20})
    .alignItems(VerticalAlign.Center)
    .onClick(()=>{
      router.pushUrl({url:"pages/Product/ProductDetail",
      params:{id:this.productRankItem.spu_id }})
    })
  }
}