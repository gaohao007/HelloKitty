import { Log } from "@abner/log"
import { getCategoryList } from "../../Api"
import { APP_TOP_HEIGHT, BASE_URL } from "../../constans"
import { Category } from "../../model"
import { ClassifyCard } from "../classifyCard"


@Component
export struct Classify{
  @State categoryList:Category[]=[]
  aboutToAppear() {
    this.getCategoryData()
  }
 async  getCategoryData(){
    const res = await getCategoryList()
   if (res) {
     this.categoryList=res
   }
 }
@State currentIndex:number=0
 @Builder
 getTabBarData(item:Category){
    Row({space:3}){
      Text(item.name)
        .fontSize(12)
        .fontColor((this.currentIndex+1)===item.id?$r("app.color.white"):$r("app.color.text_primary"))
      Image(BASE_URL+"/"+item.image)
        .width(30).aspectRatio(1)
        .objectFit(ImageFit.Fill)
    }.backgroundColor((this.currentIndex+1)===item.id?$r("app.color.primary"):$r("app.color.background_page"))
    .padding(10)
     .margin({top:20,bottom:20})
    .borderRadius(10)
    .clip(true)
 }

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      Text('分类')
        .letterSpacing(6)
        .fontSize(30)
        .fontWeight(700)
        .width('100%')
        .margin({top:10})
      Tabs(){
        ForEach(this.categoryList,(items:Category,index:number)=>{
          TabContent(){
            ClassifyCard({categoryItem:items})
  }.tabBar(this.getTabBarData(items))
          .width('100%')
          .height('100%')
        })
      }.layoutWeight(1)
      .onChange((index:number)=>{
        this.currentIndex = index
      })
      .width('100%')
      .barWidth(80)
      .vertical(true)
      .barMode(BarMode.Scrollable)
    }.width('100%')
    .height('100%')
    .padding({left:20,right:20})
  }
}