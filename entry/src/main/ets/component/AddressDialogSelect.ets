import { getUserAddressList, insertNewAddress } from "../Api"
import { differentOrderStatus } from "../Api/order"
import { AddAddressParams, AddAddressParamsModel, AddressItems, AddressItemsModel } from "../model"
import { PerferenceHelpe } from "../utils"
import { AddAddressDialog } from "./AddAddressDialog"


@Component
@CustomDialog
@Preview
export struct AddressDialogSelect{

  @State addAddressParams:AddAddressParams
    = new AddAddressParamsModel({} as AddAddressParams)

  addAddressDialog :CustomDialogController = new CustomDialogController({
    builder:AddAddressDialog({
      confirmCallback:async (data)=>{
        this.addAddressParams = data
          const userid = await new PerferenceHelpe(getContext(this)).getUserID()
          await insertNewAddress(userid,this.addAddressParams)
          this.addressList=[]
          const result = await getUserAddressList(userid)
          this.addressList = result.items
          this.addAddressDialog.close()
      }
    }),
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    autoCancel:false,
  })




  customController:CustomDialogController

  //地址列表
  @State addressList:AddressItems[] = []
  usrid:number=0
  addreessId:number=0

  @State items:AddressItems =  new AddressItemsModel({} as AddressItems)
  @State isSelectedAddress:boolean =true
  @State isSelectedIndex:number=0
  async aboutToAppear() {
    const useid = await new PerferenceHelpe(getContext(this)).getUserID()
    const result = await getUserAddressList(useid)
    this.addressList = result.items
    this.usrid = useid
    if (this.isSelectedAddress && this.addressList.length>0 && this.isSelectedIndex==0) {
      this.items = this.addressList[this.isSelectedIndex]
    }
  }



  @Builder
  getListItem(item:AddressItems,index:number){
    Row({space:5}){
      Image((this.isSelectedAddress && this.isSelectedIndex == index)?
        $r("app.media.danxuananniu2"):$r("app.media.danxuananniu1")
      ).aspectRatio(1)
        .width(24)
      Column(){
        Row({space:10}){
          Text(item.name)
          Text(item.phone)
        }
        Text(){
          Span(item.province+'  ')
          Span(item.city+'  ')
          Span(item.district+ ' ')
          Span(item.detail)
        }.fontSize(14)
      }.layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor($r("app.color.background_page"))
      .borderRadius(10)
      .padding({left:20,right:10,top:10,bottom:10})
    }.padding({left:20})
      .width('100%')
    .padding({left:10,right:20})
    .alignItems(VerticalAlign.Center)
    .height(60)
  }

  build() {
    Column(){
        Row(){
          Text('收货地址')
            .fontSize(24).fontWeight(700)
          Blank()
          Image($r('app.media.chahao')).width(24)
            .aspectRatio(1)
            .onClick(()=>{
              this.customController.close()
            })
        }.width('100%').padding(20)
      List({space:10}){
          if (this.addressList.length>0){
              ForEach(this.addressList,(item:AddressItems,index:number)=>{
                ListItem(){
                  this.getListItem(item,index)
                }
                .onClick(()=>{
                  this.isSelectedAddress = ! this.isSelectedAddress
                  this.isSelectedIndex = index
                  this.items = item
                })
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
          if (this.isSelectedAddress && this.addressList.length >=1) {
            Button('确定').width('100%')
              .type(ButtonType.Normal)
              .height(46)
              .backgroundColor($r("app.color.primary"))
              .onClick(()=>{
                this.confrimCallback(this.items)
              })
          }else {
            Button('新增地址').width('100%')
              .type(ButtonType.Normal)
              .height(46)
              .backgroundColor($r("app.color.primary"))
              .onClick(()=>{
                this.addAddressDialog.open()
              })
          }
        }.width('100%').padding({left:20,right:20})
      }
    }.width('100%')
    .height(600)
    .backgroundColor($r("app.color.white"))
    .borderRadius({topLeft:10,topRight:10})
  }
  confrimCallback:(items:AddressItems)=>void=()=>{}
}