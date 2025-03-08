@CustomDialog
@Preview
@Component
export struct  Tip{
  customController:CustomDialogController
  message:string =""
  build() {
  Column(){
        Text(this.message)
          .fontSize(20)
          .fontColor($r("app.color.white"))
          .fontWeight(500)
      }
      .width(130)
      .height(100)
      .backgroundColor($r("app.color.primary"))
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)

  }
}