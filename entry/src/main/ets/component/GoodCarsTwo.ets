import { BASE_URL } from "../constans"
import { ProductItems, ProductItemsModel } from "../model"
import { router } from "@kit.ArkUI"
import { AddCartDialog } from "./addCartDialog"

@Component
export struct GoodsCard{
  @State
  products:ProductItems =new ProductItemsModel({} as ProductItems)

  cartDialog:CustomDialogController = new CustomDialogController({
    builder:AddCartDialog({spu_id:this.products.id}),
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    autoCancel:false
  })



  build() {
    Column({space:8}){
      Image(BASE_URL+"/"+this.products?.main_image)
        .aspectRatio(1).width(100)
        .objectFit(ImageFit.Fill)
        .borderRadius(12)
        .border({width:1,color:$r("app.color.background_divider")})
        .shadow({radius:20})
      Text(this.products.description)
        .maxLines(2)
        .textOverflow({overflow:TextOverflow.Ellipsis})
        .fontSize(12)
        .fontWeight(500)
      Row(){
        Text(){
          Span("￥").fontSize(14).fontWeight(600)
          Span(this.products.skus[0]?.price.toFixed(2))
            .fontSize(18).fontWeight(700)
            .fontColor('#f32b80')
        }
        Blank()
        Image($r("app.media.gouwuche2"))
          .width(23).aspectRatio(1)
          .onClick(()=>{
            this.cartDialog.open()
          })
      }.width("100%")
      .padding({left:10,right:10})
    }.width(130)
    .onClick(()=>{
      router.pushUrl({url:'pages/Product/ProductDetail',
      params:{
        id:this.products.id
      }
      })
    })
    .height(180)
    .padding({top:5,bottom:5,left:6,right:6})
  }
}