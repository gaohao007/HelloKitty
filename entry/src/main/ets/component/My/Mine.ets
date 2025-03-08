
import { getRandomProducts } from "../../Api/products"
import { ProductItems, Products, TabClass, UserInfo, UserInfoModel } from "../../model"
import { GoodCard } from "./.."
import { promptAction, router } from "@kit.ArkUI"
import { PerferenceHelpe } from "../../utils"
import { getUserInfo } from "../../Api/user"
import { BASE_URL } from "../../constans"


@Preview
@Component
export struct Mine{

  userSetting:PerferenceHelpe = new PerferenceHelpe(getContext(this))
  @State
      userInfo:UserInfo = new UserInfoModel({} as UserInfo)


  @State tabsData:TabClass[]=[
    {
      title:"待收款",
      name:"IS_NO_PAY",
      icon:$r("app.media.no_pay")
    },

    {
      title:"打包中",
      name:"packing",
      icon:$r("app.media.packing")
    },
    {
      title:"待收货",
      name:"daishouhuo",
      icon:$r("app.media.daishouhuo")
    },

    {
      title:"评价",
      name:"pinjia",
      icon:$r("app.media.pinjia")
    },
  ]
  @State orrtabsData:TabClass[]=[
    {
      title:"商品收藏",
      name:"shoucang",
      icon:$r("app.media.shoucang")
    },

    {
      title:"钱包",
      name:"qianbao",
      icon:$r("app.media.qianbao")
    },
    {
      title:"历史浏览",
      name:"lishi",
      icon:$r("app.media.liulanjilu")
    },

    {
      title:"退款售后",
      name:"tuikuan",
      icon:$r("app.media.tuikuan")
    },
  ]
  @State isLogin:boolean=true
  user_id:number=0
  @State
    products:ProductItems[]=[]
    async aboutToAppear() {
     this.getProducts()
      const user_id = await this.userSetting.getUserID()
      this.user_id = user_id
      if (user_id === 0){
        //该用户未登录
        this.isLogin=false
      }else {
      //   用户登录
        this.isLogin=true
        const res = await getUserInfo(user_id)
        this.userInfo= res
        await new PerferenceHelpe(getContext(this)).setUserInfo(res)
      }
  }

  // 获取猜你喜欢的商品
  async  getProducts(){
    const res =await getRandomProducts() as Products
    this.products = res.items
  }

  @Builder
  displayIcon(){
    Row({}){
      Row({space:10}){
        Image(this.isLogin?BASE_URL+"/"+this.userInfo.avatar:$r("app.media.touxiang"))
          .width(30)
          .aspectRatio(1)
          .borderRadius(13)
        Column(){
          Text(this.userInfo.username ||"未登录/请先登录")
            .fontSize(20)
            .fontWeight(600)
            .onClick(()=>{
              if (!this.isLogin) {
                router.pushUrl({url:"pages/login/Login"})
              }
            })

          if (this.isLogin){
            Row({space:10}){
              Image($r("app.media.local_fill"))
                .width(15).aspectRatio(1)
                .fillColor($r("app.color.text_secondary"))
              Text('收货地址 >')
                .fontSize(12)
                .fontColor($r("app.color.text_secondary"))
            }.margin({top:5})
            .onClick(()=>{
                    router.pushUrl({url:"pages/Address/Address" })
            })
          }

        }
        .alignItems(HorizontalAlign.Start)
      }

    Blank()
      Button(){
        Row({space:10}){
          Image($r("app.media.setting"))
            .width(18).aspectRatio(1)
            .fillColor($r('app.color.text_secondary'))
          Text('设置')
            .fontColor(14)
            .fontColor($r("app.color.text_secondary"))
        }
      }.backgroundColor($r("app.color.white"))
      .width(80)
      .height(35)
      .border({width:1,color:$r("app.color.text_secondary")})
    }.width("100%")
    .alignItems(VerticalAlign.Top)
    .onClick(()=>{
      if (this.isLogin) {
        router.pushUrl({url:"pages/setting/Setting"})
      }else {
        promptAction.showToast({message:"请你先登录!",alignment:Alignment.Center})
        router.pushUrl({url:"pages/login/Login"})
      }
    })

  }

  @Builder
  orderStaus(item:TabClass){
    Column({space:5}){
      Image(item.icon)
        .width(24).aspectRatio(1)
      Text(item.title)
    }
  }

  build() {
    Column({space:10}){
      this.displayIcon()
     Row(){
        Text('我的订单').fontSize(18)
          .fontWeight(600)
       Text('查看全部 >' )
         .fontColor($r("app.color.text_secondary"))
         .fontSize(14)
     }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({top:15,bottom:15})
    Row(){
        ForEach(this.tabsData,(items:TabClass)=>{
          this.orderStaus(items)
        })
    }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(6)
        .width('100%')
        .margin({bottom:15})

      Row(){
        ForEach(this.orrtabsData,(items:TabClass)=>{
          this.orderStaus(items)
        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(6)
        .width('100%')
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
      Divider()
        .color($r("app.color.background_divider"))
        .strokeWidth(4)
        List({space:10}){
          ForEach(this.products,(productitem:ProductItems,index:number)=>{
            ListItem(){
              GoodCard({products:productitem})
            }
            .backgroundColor($r("app.color.white"))
          })
        }.width('100%')
        .backgroundColor($r("app.color.background_page"))
        .layoutWeight(1)
        .margin({bottom:10})
    }.height('100%')
    .padding({left:20,right:20,top:15})
  }
}