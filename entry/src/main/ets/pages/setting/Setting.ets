import { CardItem, NavBar } from '../../component'
import { APP_TOP_HEIGHT } from '../../constans'

@Entry
@Component
struct Setting {

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:"设置"})
      Column(){

      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}