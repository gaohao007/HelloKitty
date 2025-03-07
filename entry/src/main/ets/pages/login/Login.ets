import { APP_TOP_HEIGHT } from '../../constans';
import { LoginSuccessData,
  LoginSuccessDataModel,
  UserLoginParams,
  UserLoginParamsModel } from '../../model';
import { promptAction, router } from '@kit.ArkUI';
import { LoginForm } from '../../Api';
import { PerferenceHelpe } from '../../utils';

@Entry
@Component
struct Login {
  @State loginSuccessData:LoginSuccessData=new LoginSuccessDataModel({} as LoginSuccessData)
  @State isSelected:boolean=false
 @State userParams:UserLoginParams = new UserLoginParamsModel({} as UserLoginParams)
  @State imags:ResourceStr[]=[
    $r("app.media.weixin_mw"),
    $r("app.media.iphone"),
    $r("app.media.shouji"),
    $r("app.media.QQ"),

  ]
  build() {
    Column(){
    Row().width('100%')
      .height(AppStorage.get(APP_TOP_HEIGHT))
      .backgroundColor($r("app.color.white"))

      Row(){
      Image($r("app.media.chahao")).width(21).aspectRatio(1)
        .onClick(()=>{
          router.back()
        })
        Blank()
        Text('帮助').fontSize(14)
          .fontColor($r("app.color.text_secondary"))
      }.width('100%')
      .padding({left:20,right:20})
    Column(){
      Image($r("app.media.gou"))
        .width(120)
    }.margin({top:45})
      TextInput({placeholder:'请输入账号'})
        .margin({top:30})
        .type(InputType.Normal)
        .padding(10)
        .borderRadius(6)
        .onChange((value:string)=>{
          this.userParams.username =value
        })

      TextInput({placeholder:"请输入密码"})
        .margin({top:30})
        .type(InputType.Password)
        .padding(10)
        .borderRadius(6)
        .onChange((value:string)=>{
          this.userParams.password =value
        })

      Row(){
        Image(this.isSelected?$r("app.media.danxuananniu2"):$r("app.media.danxuananniu1"))
          .width(20).aspectRatio(1)
          .onClick(()=>{
            this.isSelected = ! this.isSelected
          })
        Text(){
          Span('我已仔细阅读并同意').fontSize(13).fontColor($r("app.color.text_secondary"))
          Span('《隐私政权》《法律声明》')
            .fontSize(13).fontColor('#5267fe')
        }
      }.width('100%')
      .margin({top:15})

      Button('登录')
        .onClick(async()=>{
          try {
            const res = await LoginForm(this.userParams) as LoginSuccessData
            this.loginSuccessData.user_id = res.user_id
            new PerferenceHelpe(getContext()).setUserID(res.user_id)
            router.replaceUrl({url:"pages/Index"})
          } catch (err) {
              promptAction.showToast({message:"登录失败",alignment:Alignment.Center})
          }
        })
        .type(ButtonType.Normal)
        .margin({top:35})
        .fontWeight(700)
        .fontSize(20)
        .height(47)
        .width('100%')
        .borderRadius(10)
        .backgroundColor(this.getButtonStatus()?$r("app.color.primary"):$r("app.color.primary_disabled"))
        .enabled(this.getButtonStatus())

      Row(){
        Text('新用户注册').TextStyles()
          .onClick(()=>{
              router.pushUrl({url:"pages/Register/register"})
        })
        Text('|').fontSize(13).TextStyles()
        Text('短信验证码登录').TextStyles()
        Text('|').fontSize(13).TextStyles()
        Text('无法登录').TextStyles()
      }.width('100%').margin({top:30})
      .justifyContent(FlexAlign.SpaceEvenly)
      Blank()
      Text('其他登录方式').TextStyles()
    Row(){
      ForEach(this.imags,(img:ResourceStr)=>{
        Image(img) .aspectRatio(1)
          .width(36)
      })
    }.margin({bottom:20,top:20})
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .height('100%')
    .width('100%')
    .padding({left:20,right:20})



  }
  getButtonStatus(){
    if(this.isSelected && this.userParams.username && this.userParams.password){
      return true
    }
    return false
  }
}
@Extend(Text)
function TextStyles(){
  .fontSize(13).fontColor($r("app.color.text_secondary"))
}