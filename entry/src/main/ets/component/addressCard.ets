import { AddAddressParams, AddressItems, AddressItemsModel } from "../model/address"
import { PerferenceHelpe } from "../utils"
import { AddUserAddress } from "./AddUserAddress"


@Component
export struct AddressCard{
  @State address:AddressItems=new AddressItemsModel({} as AddressItems)
  deleteUserSomeoneAddress:(id:number)=>void=()=>{}
   confrimCallBackUpdateUserAddressIfo:(data:AddAddressParams,addressId:number)=>void=()=>{
         this.updateUserAddressInfo.close()
  }

  @State username:string=""
  @State userPhone:string=''

  // 修改弹窗
  updateUserAddressInfo:CustomDialogController = new CustomDialogController({
    builder:AddUserAddress({
      isUpdateUserAddressInfo:true,
      userName:this.username,
      userPhone:this.userPhone,
      updateUserAddressInfo: (data:AddAddressParams,id:number)=>{
        this.confrimCallBackUpdateUserAddressIfo(data,id)
      }
    })
    ,autoCancel:false,
    customStyle:true,
    alignment:DialogAlignment.Center
  })



  build() {
    Column(){
      Row(){
        Blank()
         Image($r("app.media.chahao1")).width(16).aspectRatio(1)
           .onClick(()=>{
            this.deleteUserSomeoneAddress(this.address.id)
           })
      }.width('100%')
      .padding({right:20})

          Column({space:4}){
            Text(this.address.name+' , '+this.address.phone)
              .fontSize(14)
              .fontWeight(500)
              .width('100%')
            Text(){
              Span(this.address.province+'  ')
              Span(this.address.city+'  ')
              Span(this.address.district+ ' ')
              Span(this.address.detail)
            }.fontSize(14)
            .width('100%')
          }.padding(10)
      .width('100%')
      .border({width:{bottom:1},color:$r("app.color.background_divider")})
      Row({space:5}){
          Image(this.address.is_default===1?$r('app.media.youmoren'):$r("app.media.morenmeiyou"))
            .width(20).aspectRatio(1)
            .onClick(()=>{
                      this.updateDefault(this.address.id)
            })
        Text(this.address.is_default===1?"已设默认":"默认")
        .fontSize(14)
          .fontColor(this.address.is_default===1?$r("app.color.black"):$r("app.color.text_secondary"))

        Blank()
        Button(`修改`)
          .width(70)
          .height(30)
          .fontColor($r("app.color.black"))
          .border({width:1,color:$r("app.color.text_secondary")})
          .fontSize(12)
          .backgroundColor($r("app.color.white"))
          .type(ButtonType.Normal)
          .borderRadius(4)
          .onClick(async ()=>{
            //修改地址工鞥
            this.username = this.address.name
            this.userPhone = this.address.phone
           await new PerferenceHelpe(getContext(this)).setAddressID(this.address.id)
            this.updateUserAddressInfo.open()
          })
      }
      .width('100%')
      .padding({left:10,right:10,top:13,bottom:20})
    }.width('100%')
    .padding({top:10,bottom:10})
  }
  // 修改默认地址
  updateDefault:(addressID:number)=>void =()=>{}
}