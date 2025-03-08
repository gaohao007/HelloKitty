
import { getProvice } from "../Api"
import { AddressAreaData } from "../model"


@Component
@CustomDialog
export struct SelectAddressDialog{



  customController:CustomDialogController
  confrimCallback:(provice:string,city:string,area:string)=>void=()=>{}
  @State provice:string=""
  @State city:string=""
  @State area:string=""
  @State addressAreaDataList:AddressAreaData[]=[]
   parent_Id:number=0
  aboutToAppear(): void {
    this.getAreaDate()
  }
  async getAreaDate(){
    this.addressAreaDataList = await getProvice(this.parent_Id)
  }
  build() {
        Column(){
        Row({space:5}){
          Text(this.provice||'请选择地区')
            .fontSize(18)
            .fontWeight(500)

          if (this.city){
            Text(this.city)
              .fontSize(18)
              .fontWeight(500)
          }
          if (this.area){
            Text(this.area)
              .fontSize(18)
              .fontWeight(500)
          }
          Blank()
          Image($r("app.media.chahao"))
            .width(20).aspectRatio(1)
            .onClick(()=>{
              this.customController.close()
            })
        }.width('100%')
          .border({width:{bottom:1},color:$r("app.color.background_divider")})

          List({space:4}){
              ForEach(this.addressAreaDataList,(item:AddressAreaData)=>{
                ListItem(){
                  Row(){
                          Text(item.name)
                            .fontSize(15)
                            .fontWeight(500)
                          Blank()
                          Image($r("app.media.xiangyoujiantou"))
                            .width(18).aspectRatio(1)
                            .onClick(async ()=>{
                              // 第一次点击
                              if (item.parent_id === 0 &&  this.provice ==="" && this.city==="" && this.area ==="") {
                                if (item.name==="北京市" || item.name==="上海市" || item.name==="天津市" || item.name==="上海市") {
                                  this.provice= item.name
                                  this.city=item.name
                                } else{
                                      this.provice= item.name
                                      this.city=""
                                }
                                this.addressAreaDataList=[]
                                const  res = await getProvice(item.id)
                                this.addressAreaDataList=res
                              }
                              // 第二次点击
                              if (item.parent_id !== 0 &&  this.city ===""  &&  this.area ==="") {
                                this.city =item.name
                              }
                              //第三次点击怎么排除
                              if ( item.parent_id !== 0  &&  this.city !==""  &&  this.area ==="") {
                                this.addressAreaDataList=[]
                                const  res = await getProvice(item.id)
                                this.addressAreaDataList=res
                                if (this.city !=="" && this.city !== item.name) {
                                  this.area = item.name
                                }
                              }

                            })
                  }.width('100%')
                }.border({width:{bottom:1},color:$r("app.color.background_divider")})
                  .margin({top:10,bottom:10})



              })
            ListItem(){
              Button('确定')
                .type( ButtonType.Normal)
                .width('100%')
                .enabled(this.getButtonStatus())
                .backgroundColor(this.getButtonStatus()?$r("app.color.primary"):$r("app.color.primary_disabled"))
                .onClick(()=>{
                  this.confrimCallback(this.provice,this.city,this.area)
                  this.customController.close()
                })
            }.width('100%')
            .margin({left:20,right:20,bottom:10,top:10})
          }

        }.width('100%')
         .backgroundColor($r("app.color.white"))
        .height(360)
        .padding({left:20,right:20,bottom:30,top:30})
        .borderRadius({topLeft:10,topRight:10})
  }
  getButtonStatus(){
    if (this.provice && this.city && this.area) {
      return true
    }
    return false
  }
}