import { AdvertiseData, AdvertiseDataModel, Advertiseitem } from '../../model';
import { PerferenceHelpe } from '../../utils';
import { window } from '@kit.ArkUI';
import { ADVERTISE_WINDOW_NAME, APP_BOTTOM_HEIGHT, APP_TOP_HEIGHT, BASE_URL } from '../../constans';

@Entry
@Component
struct Start {
  @State message: string = '广告页面';
  adverSetting: PerferenceHelpe = new PerferenceHelpe(getContext(this))
  @State
    adObj :AdvertiseData = new AdvertiseDataModel({} as AdvertiseData)
  @StorageProp(APP_BOTTOM_HEIGHT)
  adToBottom: number = 0;
  async aboutToAppear() {
    this.adObj = await this.adverSetting.getAdvertiseData()
  }
  build() {
    Stack({alignContent:Alignment.BottomEnd}){
      Swiper(){
        ForEach(this.adObj.items,(item:Advertiseitem,index:number)=>{
          Image(BASE_URL+"/"+item.image)
            .width('100%')
            .height("100%")
        })
      }.width('100%')
      .layoutWeight(1)
      Text(`跳转`)
        .borderRadius(15)
        .backgroundColor($r("app.color.white"))
        .opacity(.75)
        .padding(10)
        .margin({right:20,bottom:this.adToBottom})
        .onClick(()=>{
          window.findWindow(ADVERTISE_WINDOW_NAME).destroyWindow()
        })
    }.width('100%')
    .height('100%')
    .padding({top:AppStorage.get(APP_TOP_HEIGHT) as number,bottom:AppStorage.get(APP_BOTTOM_HEIGHT) as number})
  }
}