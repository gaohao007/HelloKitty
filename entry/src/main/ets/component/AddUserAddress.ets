import { Log } from "@abner/log"
import { SelectAddressDialog } from "."
import { AddAddressParams, AddAddressParamsModel } from "../model"
import { UserInfo, UserInfoModel } from "../model/user"
import { PerferenceHelpe } from "../utils"


@Component
@CustomDialog
export struct AddUserAddress{
@State
// 是否是修改地址
  isUpdateUserAddressInfo:boolean=false

  selectAddressLayer:CustomDialogController =new CustomDialogController({
    builder:SelectAddressDialog({
      confrimCallback:(provice:string,city:string,area:string)=>{
        this.addressParams.province = provice
        this.addressParams.city = city
        this.addressParams.district= area
      }
    }),
    alignment:DialogAlignment.Bottom,
    autoCancel:false,
    customStyle:true
  })

  customerController:CustomDialogController
@State
    addressParams:AddAddressParams= new AddAddressParamsModel({} as AddAddressParams)
  @State
        isDefaultAddress:boolean=false
  @State userName:string=""
  @State userPhone:string=""
  @State showOne:boolean=true
  @State showTwo:boolean=true
  @State userinfo:UserInfo = new  UserInfoModel({} as UserInfo)
    async aboutToAppear() {
    const res = await new PerferenceHelpe(getContext(this)).getUserInfo()
      Log.info(JSON.stringify(res))
      this.userinfo = res
      if (this.userName ==="") {
        this.userName = this.userinfo.username
      }
      if (this.userPhone ==="") {
        this.userPhone =  this.userinfo.phone
      }

}
  build() {
    Column({space:6}){

      Row(){
        Text(this.isUpdateUserAddressInfo ? '修改收货地址' :'添加收货地址')
          .fontSize(18)
          .fontWeight(500)
        Blank()
        Image($r("app.media.chahao123"))
          .width(20).aspectRatio(1)
          .onClick(()=>{
            this.customerController.close()
          })
      }.width('100%')
      .padding({left:20,right:20})
      .margin({top:20,bottom:20})


       Divider().strokeWidth(1).color($r("app.color.background_divider"))
         .padding({left:20,right:20})
      Row(){
        Text("收货人")
          .fontColor($r("app.color.black"))
          .fontWeight(500)
          TextArea({text:this.userName}).width('50%')
            .backgroundColor($r("app.color.white"))
            .borderRadius(0)
            .onChange((value:string)=>{
                this.userName=value
                this.addressParams.name=this.userName
            })
            .onFocus(()=>{
                this.showOne = true
                this.showTwo = false
            })
            .onBlur(()=>{
              this.showOne = false
              this.showTwo = false
            })
        Blank()
        if (this.showOne && ! this.showTwo){
          Image($r("app.media.chahao"))
            .width(18).aspectRatio(1)
            .onClick(()=>{
              this.userName=""
            })
        }
      }.width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .padding({left:20,right:20})

      Row(){
        Text("手机号")
          .fontColor($r("app.color.black"))
          .fontWeight(500)

        TextArea({text:this.userPhone}).width('50%')
          .backgroundColor($r("app.color.white"))
          .borderRadius(0)
          .onChange((value:string)=>{
            this.userPhone=value
            this.addressParams.phone=this.userPhone
          })
          .onFocus(()=>{
            this.showOne = false
            this.showTwo = true
          })
          .onBlur(()=>{
            this.showOne = false
            this.showTwo = false
          })
        Blank()
        if (!this.showOne &&  this.showTwo){
          Image($r("app.media.chahao"))
            .width(18).aspectRatio(1)
            .onClick(()=>{
              this.userPhone=""
            })
        }
      }.width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .padding({left:20,right:20})

      Row({space:20}){
        Text("地区")
          .fontColor($r("app.color.black"))
          .fontWeight(500)

        Text((this.addressParams.province+this.addressParams.city+this.addressParams.district)||'点击选择')
          .fontSize(13)
          .fontColor($r("app.color.text_secondary"))
        Blank()
          Image($r("app.media.xiangyoujiantou"))
            .width(18).aspectRatio(1)
            .onClick(()=>{
                this.selectAddressLayer.open()
            })
      }.width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .padding({left:20,right:20})

      Row(){
        Text("详细地址")
          .fontColor($r("app.color.black"))
          .fontWeight(500)

        TextArea({placeholder:"如街道、门牌号,小区,乡镇"}).width('50%')
          .backgroundColor($r("app.color.white"))
          .placeholderFont({size:12,})
          .placeholderColor($r("app.color.text_secondary"))
          .borderRadius(0)
          .onChange((value:string)=>{
                this.addressParams.detail=value
          })

      }.width('100%')
      .padding({left:20,right:20})
      .height(48)
      .alignItems(VerticalAlign.Center)

      Row({space:6}){
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
        this.addressParams.is_default = this.isDefaultAddress
      })

      Button(this.isUpdateUserAddressInfo? '修改' :'保存')
        .width('88%')
        .enabled(this.getButtonStatus())
        .type(ButtonType.Normal)
        .borderRadius(10)
        .fontColor($r("app.color.white"))
        .fontWeight(600)
        .backgroundColor(this.getButtonStatus()?$r("app.color.primary"):$r("app.color.primary_disabled"))
        .margin({bottom:30})
        .onClick(async ()=>{
          if (this.isUpdateUserAddressInfo) {
            const id =await new PerferenceHelpe(getContext(this)).getAddressID()
            this.updateUserAddressInfo(this.addressParams,id)
            this.customerController.close()
          }else {
            this.confrimcallBackToSaveUserAddress(this.addressParams,)
          }
        })

    }.width('100%')
    .borderRadius(10)
    .backgroundColor($r("app.color.white"))
  }
  confrimcallBackToSaveUserAddress:(data:AddAddressParams)=>void=()=>{}
  updateUserAddressInfo:(data:AddAddressParams,id:number)=>void=()=>{}

  getButtonStatus(){
    if (this.addressParams.name && this.addressParams.phone
    && this.addressParams.detail && this.addressParams.province
      && this.addressParams.city && this.addressParams.district
      && this.addressParams.is_default
    ) {
  return true

    }
    return false
  }
}
































































































