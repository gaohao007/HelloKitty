
import { APP_BOTTOM_HEIGHT, APP_TOP_HEIGHT } from '../constans'
import { TabClass } from '../model'
import { Mine } from '../component/My/Mine'
import { Cart, Classify, Home } from '../component'


@Entry
@Component
struct Index {


  @State curentName:string  ="Home"
  @State tabsData:TabClass[]=[
    {
      title:"首页",
      name:"Home",
      icon:$r("app.media.Home")
    },

    {
      title:"列表",
      name:"List",
      icon:$r("app.media.list")
    },

    {
      title:"购物车",
      name:"Cart",
      icon:$r("app.media.cart")
    },

    {
      title:"我的",
      name:"Mine",
      icon:$r("app.media.Mine")
    },
  ]

@Builder
getTab(item:TabClass){
    Column(){
      Image(item.icon)
        .width(26).aspectRatio(1)
        .fillColor(item.name == this.curentName ?$r("app.color.primary"):$r("app.color.text_secondary"))
      Text(item.title)
        .fontSize(13)
        .margin({top:8})
        .fontColor(item.name == this.curentName ?$r("app.color.primary"):$r("app.color.text_secondary"))
    }.alignItems(HorizontalAlign.Center)
}

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r('app.color.white'))
      Tabs({barPosition:BarPosition.End,index:0}){
        ForEach(this.tabsData,(item:TabClass)=>{
          TabContent(){
            if (item.name === "Mine") {
              Mine()
            }else if (item.name ==="Home"){
              Home()
            }else if (item.name === "List"){
              Classify()
            }else if (item.name === "Cart"){
              Cart()
            }

          }.tabBar(this.getTab(item))
        })
      }.onChange((index)=>{
          this.curentName=this.tabsData[index].name!
      })
      .animationDuration(200)
    }
    .padding({
      bottom:AppStorage.get<number>(APP_BOTTOM_HEIGHT)
    })
  }
}