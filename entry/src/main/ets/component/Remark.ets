import { ProductItems, Products, Remark_items } from "../model"
import { PerferenceHelpe } from "../utils"
import { promptAction, router } from "@kit.ArkUI"
import { deleteRemark, getRandomProducts, getRemark } from "../Api"
import { GoodCard, RemarkCard } from "./"


@Component
export struct  RemarkComent{
  @State remarkItems:Remark_items[]=[]

  aboutToAppear(): void {
    this.getRemrkList()
    this.getProducts()
  }

async   getRemrkList(){
    const user_id = await new PerferenceHelpe(getContext(this)).getUserID()
  if (user_id !==0) {
      const res = await getRemark(user_id)
     this.remarkItems = res.items
  }else {
    promptAction.showToast({message:"请先登录"})
    router.pushUrl({url:"pages/login/Login"})
  }
}
// 删除评论
  async deleteRemark(remarkid:number,userid:number){
    await deleteRemark(remarkid,userid)
    this.getRemrkList()
  }

  @State
  products:ProductItems[]=[]
  // 获取猜你喜欢的商品
  async  getProducts(){
    const res =await getRandomProducts() as Products
    this.products = res.items

  }

  build() {
    Column(){
        List({space:10}){
          ListItem(){
            Row(){
              Blank()
              Image($r("app.media.shuaxin_000002")).aspectRatio(1).width(20)
                .onClick(()=>{
                  this.getRemrkList()
                })
            }.width('100%')
          }
          if (this.remarkItems.length>0){
            ForEach(this.remarkItems,(items:Remark_items)=>{
              ListItem(){
                RemarkCard({remarkItems:items,
                deleteSomeoneRemark:(remarkId,userid)=>{
                    this.deleteRemark(remarkId,userid)
                  promptAction.showToast({message:"删除成功"})
                }
                })
              }.width('100%')
            })
          }
          else {
            ListItem(){
              Row(){
                Text('暂无评论')
                  .fontSize(30)
                  .fontColor($r("app.color.text_secondary"))
              }.width('100%')
              .justifyContent(FlexAlign.Center)
            }
            ListItem(){
              Row(){
                Text('猜你喜欢 ❤')
                Row({space:5}){
                  Image($r("app.media.shuaxin")).height(20).aspectRatio(1)
                  Text('刷新一下')
                    .fontColor($r("app.color.text_secondary"))
                    .fontSize(14)
                }
                .onClick(async ()=>{
                  this.products=[]
                  await this.getProducts()
                })
              }.width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({top:10})
            }
            ForEach(this.products,(productitem:ProductItems)=>{
              ListItem(){
                GoodCard({products:productitem})
              }
              .backgroundColor($r("app.color.white"))
              .borderRadius(10)
              .clip(true)
            })
          }

        }.width('100%')
        .margin({bottom:120})
        .scrollBar(BarState.Off)

    }.width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor($r("app.color.background_page"))
  }
}