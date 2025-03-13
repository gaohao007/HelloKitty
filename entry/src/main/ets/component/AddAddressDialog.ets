import { SelectAddressDialog } from "."
import { AddAddressParams, AddAddressParamsModel } from "../model"


@Component
@CustomDialog
export struct AddAddressDialog{

  selectCityProviceDistrictDialog:CustomDialogController =
    new CustomDialogController({
      builder:SelectAddressDialog({confrimCallback:(
        provice:string,city:string,area:string
      )=>{
        this.addAddress.province = provice
        this.addAddress.city = city
        this.addAddress.district = area
      }}),
      autoCancel:false,
      customStyle:true,
      alignment:DialogAlignment.Bottom
    })
  customerController:CustomDialogController
  @State
  isDefaultAddress:boolean=false




@State addAddress:AddAddressParams = new AddAddressParamsModel({} as AddAddressParams)


  build() {
    Column({space:23}){
        Row(){
          Text('添加收货地址')
            .fontSize(18)
            .fontWeight(500)
            .fontColor($r("app.color.black"))
            .margin({left:20})
            .margin({top:20,bottom:20})
          Blank()
          Image($r("app.media.chahao"))
            .width(20).aspectRatio(1)
            .onClick(()=>{
              this.customerController.close()
            })
        }.width('100%')
        .padding({left :20,right:20})
      .border({width: {bottom:1 },color:$r("app.color.background_divider")})
     Row(){
          Text('收货人')
          TextInput({placeholder:"请输入收货人姓名",})
            .layoutWeight(1)
            .margin({left:20,right:20})
            .type(InputType.Normal)
            .backgroundColor($r("app.color.white"))
            .borderRadius(0)
            .onChange((value:string)=>{
             this.addAddress.name = value
            })
     }.width('100%')

     .padding({left:20,right:20})


      Row(){
        Text('手机号')
        TextInput({placeholder:"请输入手机号",})
          .layoutWeight(1)
          .margin({left:20,right:20})
          .type(InputType.Normal)
          .backgroundColor($r("app.color.white"))
          .borderRadius(0)
          .onChange((value:string)=>{
            this.addAddress.phone = value
          })
      }.width('100%')
      .padding({left:20,right:20})


      Row(){
        Text('地区')
        Text((this.addAddress.province
          +this.addAddress.city+
        this.addAddress.district)||'点击选择')
          .layoutWeight(1)
          .margin({left:20,right:20})
          .fontColor($r("app.color.text_secondary"))
          .fontSize(14).margin({left:40})
        Blank()
        Image($r("app.media.xiangyoujiantou"))
          .width(20).aspectRatio(1)
          .margin({right:20})
          .onClick(()=>{
            this.selectCityProviceDistrictDialog.open()
          })
      }.width('100%')
      .padding({left:20,right:20})


      Row(){
        Text('详细地址')
        TextInput({placeholder:"如街道,门牌号小区",})
          .layoutWeight(1)
          .margin({left:20,right:20})
          .type(InputType.Normal)
          .backgroundColor($r("app.color.white"))
          .borderRadius(0)
          .onChange((value:string)=>{
            this.addAddress.detail = value
          })
      }.width('100%')
      .padding({left:20,right:20})


      Row({space:20}){
        Image(this.isDefaultAddress?$r("app.media.youmoren"):$r("app.media.morenmeiyou"))
          .aspectRatio(1)
          .width(24)
        Text("是否设置为默认地址")
          .fontSize(13)
          .fontColor($r("app.color.text_secondary"))
      }.width('100%')
      .padding({left:20,right:20})
      .margin({top:10,bottom:10})
      .onClick(()=>{
        this.isDefaultAddress = !this.isDefaultAddress
        this.addAddress.is_default = this.isDefaultAddress
      })

      Row(){
          Button('确认添加')
            .type(ButtonType.Normal)
            .enabled(this.getButtonStatus())
            .width('100%')
            .backgroundColor(this.getButtonStatus() ?$r("app.color.primary"):$r("app.color.primary_disabled"))
            .fontSize(18)
            .fontWeight(600)
            .borderRadius(10)
            .onClick(()=>{
              this.confirmCallback(this.addAddress)
            })
      }.width('100%')
      .padding({left:20,right:20})
    }.width('100%')
    .height(480)
    .backgroundColor($r("app.color.white"))
    .borderRadius({topLeft:20,topRight:20})
  }
  getButtonStatus(){
    if (this.addAddress.name && this.addAddress.phone
      && this.addAddress.province &&
    this.addAddress.city &&
    this.addAddress.district && this.addAddress.detail)
    {
      return true
    }
    return false
  }
  confirmCallback:(data:AddAddressParams)=>void=()=>{}
}

