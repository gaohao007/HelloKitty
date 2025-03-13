import { Confirmdelete, NavBar } from '../../component'
import {  APP_TOP_HEIGHT } from '../../constans'
import { AddAddressParams, AddAddressParamsModel, AddressItems } from '../../model'
import { deleteSomeoneUserSomeoneAddress, getUserAddressList, insertNewAddress,
  updateDefalt,
  updateUserAddressInfo } from '../../Api'
import { PerferenceHelpe } from '../../utils'
import { AddressCard } from '../../component/addressCard'
import { promptAction } from '@kit.ArkUI'
import { AddUserAddress } from '../../component/AddUserAddress'

@Entry
@Component
 struct Address {
confirm:CustomDialogController = new CustomDialogController({
  builder:Confirmdelete({
    message:"确定删除地址吗?",
    buttonList:[
      {
        title:"取消",
        fontsize:14,
        fontColor:$r("app.color.text_secondary"),
        action:()=>{
          this.confirm.close()
        }
      },
      {
        title:"确定",
        fontsize:14,
        fontColor:$r("app.color.primary"),
        action:async ()=>{
          await this.deleteUserSomeoneAddress(this.addreessId)
        }
      }
    ] }),
  customStyle:true,
  alignment:DialogAlignment.Center,
  autoCancel:false,

})

 @State
    addAddressParams:AddAddressParams= new AddAddressParamsModel({} as AddAddressParams)
  //添加新地址
  async confirmAddAddressToUser(){
    try {
        await insertNewAddress(this.usrid, this.addAddressParams)
        const result = await getUserAddressList(this.usrid)
        this.addressList = result.items
        this.addAdress.close()
    } catch (err) {
      promptAction.showToast({message:"插入用户地址失败"})
    } finally {
      promptAction.showToast({
        message:"添加成功",
        alignment:Alignment.Center,
        duration:1000,
        backgroundColor:$r("app.color.gray_4"),
        textColor:$r("app.color.white"),
        backgroundBlurStyle:BlurStyle.BACKGROUND_THIN
      })
    }
  }
//t添加地址弹窗
addAdress:CustomDialogController = new CustomDialogController({
  builder:AddUserAddress({
    confrimcallBackToSaveUserAddress:(data:AddAddressParams)=>{
      this.addAddressParams = data
      this.confirmAddAddressToUser()

    }
  }),
  customStyle:true,
  alignment:DialogAlignment.Center,
  autoCancel:false,
})


//地址列表
@State addressList:AddressItems[] = []
  usrid:number=0
  addreessId:number=0
  @State userAddressId:number=0

async aboutToAppear() {
    const useid = await new PerferenceHelpe(getContext(this)).getUserID()
    const result = await getUserAddressList(useid)
    this.addressList = result.items
    this.usrid = useid
}

  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:"收货地址"})
      Divider().strokeWidth(1).color($r("app.color.background_divider"))
      List({space:10}){
        if (this.addressList.length>0){
          ForEach(this.addressList,(item:AddressItems,index:number)=>{
            ListItem(){
              AddressCard({address:item,
                deleteUserSomeoneAddress:(id:number)=>{
                this.addreessId=id
                this.confirm.open()
              },
                confrimCallBackUpdateUserAddressIfo:async (data,address_ID:number)=>{
                this.addAddressParams = data
               this.userAddressId = address_ID
               await this.updateAddress(this.usrid,this.addAddressParams,address_ID)

                },
                updateDefault:async (uddd:number)=>{
                console.log('-sd-s-d-sd-sd-s-ds',JSON.stringify(uddd))
                await this.updateDefault(uddd)
                }
              })
            }.backgroundColor($r("app.color.white"))
          })
        }else {
              ListItem(){
                Column({space:10}){
                  Image($r("app.media.shouhuodizhi"))
                    .width(80).aspectRatio(1)
                  Text('暂无收货地址')
                    .fontSize(17)
                    .fontColor($r("app.color.gray_8"))
                }.width('100%').margin({top:20,bottom:20})
              }
        }

        ListItem(){
          Column(){
              Button(){
                Row({space:10}){
                  Image($r("app.media.jiahao")).aspectRatio(1)
                    .width(20)
                    .fillColor($r("app.color.white"))
                  Text('添加收货地址')
                    .fontSize(18)
                    .fontColor($r("app.color.white"))
                    .fontWeight(500)
                }.padding(5)
              }.width('100%')
              .height(48)
            .type(ButtonType.Normal)
            .backgroundColor("#d81e06")
            .borderRadius(6)
          }.width('100%')
          .padding({left:20,right:20})
        }.onClick(()=>{
          //添加收货地址工鞥
          this.addAdress.open()
        })
      }
      .width('100%')
      .layoutWeight(1)
      .margin({bottom:30})

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))

  }
  // 删除地址
 async  deleteUserSomeoneAddress(id:number){
   try {
          await deleteSomeoneUserSomeoneAddress(this.usrid,id)
          const result = await getUserAddressList(this.usrid)
          this.addressList = result.items
          this.confirm.close()
         promptAction.showToast({
           message:"删除成功",
           alignment:Alignment.Center,
           duration:1000,
           backgroundColor:$r("app.color.gray_4"),
           textColor:$r("app.color.white"),
           backgroundBlurStyle:BlurStyle.BACKGROUND_THIN
        })
   } catch (err) {
      promptAction.showToast({message:"系统出现错误"})
   } finally {
   }
  }
  //修改地址
 async  updateAddress(userid:number, data:AddAddressParams, addressId:number){
    await updateUserAddressInfo(userid,data,addressId)
   const result = await getUserAddressList(this.usrid)
   this.addressList = result.items
   promptAction.showToast({
     message:"更新成功",
     alignment:Alignment.Center,
     duration:1000,
     backgroundColor:$r("app.color.gray_4"),
     textColor:$r("app.color.white"),
     backgroundBlurStyle:BlurStyle.BACKGROUND_THIN
   })
 }

  async  updateDefault(ad:number){
      await updateDefalt(this.usrid,ad)
      const result = await getUserAddressList(this.usrid)
      this.addressList = result.items
    promptAction.showToast({
      message:"设置成功",
      alignment:Alignment.Center,
      duration:1000,
      backgroundColor:$r("app.color.gray_4"),
      textColor:$r("app.color.white"),
      backgroundBlurStyle:BlurStyle.BACKGROUND_THIN
    })
  }
}