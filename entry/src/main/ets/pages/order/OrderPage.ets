
import { AllOrders, NavBar, RemarkComent, Wattingpay } from '../../component'
import { APP_TOP_HEIGHT } from '../../constans'
import { TabClass } from '../../model'

@Entry
@Component
struct OrderPage {

@State currentIndex:number=0
 @State tabData:TabClass[]=[
  {
      title:"全部",
      name:"all"
  },
  {
    title:"待付款",
    name:"waitpay"
  },
  {
    title:"打包中",
    name:"packing"
  },
  {
    title:"待收货",
    name:"daishouhuo"
  },
  {
    title:"待评价",
    name:"remark"
  }
]
  @Builder
    tabContent(item:TabClass,index:number){
        Column({space:5}){
          Text(item.title).width(60)
            .fontColor(this.currentIndex ==index?"#f03867":$r("app.color.text_secondary"))
            .fontSize(18).fontWeight(600)
            .textAlign(TextAlign.Center)
          Divider().strokeWidth(this.currentIndex ==index?2:0)
            .color('#f03867').width(this.currentIndex ==index?60:0)
        }
    }

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:"我的订单"})
      Tabs({barPosition:BarPosition.Start}){
            ForEach(this.tabData,(item:TabClass,index:number)=>{
              TabContent(){
                if (item.name == "all") {
                  AllOrders()
                }else if (item.name =="waitpay"){
                  Wattingpay({status:1})
                }else if (item.name =="packing"){
                  Wattingpay({status:2})
                }else if (item.name =="daishouhuo"){
                  Wattingpay({status:3})
                } else if (item.name =="remark"){
                    RemarkComent()
                }

              }.tabBar(this.tabContent(item,index))
            })
      }.vertical(false)
      .barHeight(60)
      .barWidth('100%')
      .barBackgroundColor($r("app.color.white"))
      .onChange((index:number)=>{
        this.currentIndex=index
      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}