import { BASE_URL } from "../constans"
import { ProductItems, ProductItemsModel } from "../model/product"
import { promptAction } from "@kit.ArkUI"


@Component
export  struct GoodCard{
  @State
  products:ProductItems = new ProductItemsModel({} as ProductItems)
  build() {
   Row(){
      Image(BASE_URL+"/"+this.products.main_image)
        .width(160)
        .height(160)
        .objectFit(ImageFit.Fill)
        .border({width:1,color:$r('app.color.text_secondary')})
        .shadow({ radius:20, color: $r("app.color.text_secondary") })
        .borderRadius(10)
      Column(){
          Text(this.products.description)
            .fontSize(18)
            .maxLines(2)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .onTouch(()=>{
              promptAction.showToast({message:this.products.description,alignment:Alignment.Center})
            })
        Row(){
            Text(){
              Span('¥  ').fontColor($r("app.color.primary"))
                .fontSize(14)
                .fontWeight(600)
              Span(this.products.skus[0].price.toFixed(2))
                .fontSize(20)
                .fontColor($r('app.color.primary'))
                .fontWeight(700)
            }
            Blank()

            Image($r("app.media.cart_12221332"))
              .width(24)
              .aspectRatio(1)
        }.width(120)
        .height(26)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .height(100)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
     .margin({left:10})
   }.width('100%')
   .justifyContent(FlexAlign.SpaceBetween)
   .alignItems(VerticalAlign.Center)
   .height(188)
    .padding(10)
    .borderRadius(20)
  }
  onclickCallback:()=>void=()=>{}
}