import { BASE_URL } from "../constans"
import { Remark_items, Remark_itemsModel, SpuInfoItem, SpuInfoItemModel } from "../model"
import { promptAction, router } from "@kit.ArkUI"
import { PerferenceHelpe } from "../utils"

@Component
export struct  RemarkCard{
  @State remarkItems: Remark_items = new Remark_itemsModel({} as Remark_items)
  @State spuInfo:SpuInfoItem = new SpuInfoItemModel({} as SpuInfoItem)
  aboutToAppear(): void {
    if (this.remarkItems.spu) {
      this.spuInfo =  this.remarkItems.spu
    }
  }
  build() {
    Column({space:10}){
        Row({space:10}){
          Image(BASE_URL+"/"+this.remarkItems.avatar).aspectRatio(1)
            .width(30).objectFit(ImageFit.Fill)
            .borderRadius(15)
          Column({space:5}){
            Text(this.remarkItems.username)
            Text(){
              Span(this.remarkItems.created_at+"评价").fontSize(12).fontColor($r("app.color.text_secondary"))
            }
          }.alignItems(HorizontalAlign.Start)
        }.width('100%')
      .alignItems(VerticalAlign.Top)
      Row(){
          Text(this.remarkItems.content)
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis})
      }.width('100%')
      Row(){
          Text(){
            Span("综合评分: "+this.remarkItems.rate+'星')
              .fontSize(12).fontColor($r("app.color.text_secondary"))
          }
      }.width('100%')
      Row(){
          Image(BASE_URL+'/'+this.spuInfo.main_image)
            .width(60).aspectRatio(1)
            .objectFit(ImageFit.Fill)
            .border({width:1,color:$r("app.color.background_divider"),radius:6})
        Text(this.spuInfo.description)
          .maxLines(1)
          .constraintSize({minWidth:100,maxWidth:180})
          .textOverflow({overflow:TextOverflow.Ellipsis})
      }.width('100%')
      .backgroundColor($r("app.color.background_page"))
      .alignItems(VerticalAlign.Center)
      .borderRadius(8)
      Row({space:10}){
          Blank()
         Button('再次购买')
           .width(100)
           .height(45)
           .fontColor($r("app.color.text_primary"))
           .backgroundColor($r("app.color.white"))
           .border({width:1,color:$r("app.color.background_divider"),radius:6})
           .type(ButtonType.Normal)
           .onClick(()=>{
             router.pushUrl({url:"pages/Product/ProductDetail",
               params:{
                 id:this.remarkItems.spu_id
               }
             })
           })
        Button('删除评论')
          .width(100)
          .height(45)
          .backgroundColor($r("app.color.primary"))
          .border({width:1,color:$r("app.color.background_divider"),radius:6})
          .type(ButtonType.Normal)
          .onClick(async ()=>{
            const user_id = await new PerferenceHelpe(getContext(this)).getUserID()
            if (user_id !==0) {
              if (this.remarkItems.id) {
                this.deleteSomeoneRemark(this.remarkItems.id,user_id)
              }
            }else {
              promptAction.showToast({message:'请先登录',alignment:Alignment.Center})
              router.pushUrl({url:'pages/login/Login'})
            }
          })
      }.width('100%')
    }.width('100%')
    .backgroundColor($r("app.color.white"))
    .padding(20)
    .borderRadius(10)
  }
  // 删除评论
  deleteSomeoneRemark:(id:number,user_id:number)=>void = ()=>{
  }
}











