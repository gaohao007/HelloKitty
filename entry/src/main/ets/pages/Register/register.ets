import { Log } from '@abner/log';
import {  verificationCode ,registerFuncall} from '../../Api';
import { NavBar } from '../../component';
import { APP_TOP_HEIGHT } from '../../constans';
import { RegisterParams, RegisterParamsModel, VerificationCode, VerificationCodeModel } from '../../model/register';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Register {
  @State isSelected:boolean=false
  @State verifyCode:VerificationCode= new VerificationCodeModel({} as VerificationCode)
  @State registerParams:RegisterParams = new RegisterParamsModel({} as RegisterParams)
@State phone:string = ''
  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
      NavBar({title:"用户注册"})
      Column(){
        Image($r("app.media.gou"))
          .width(120)
      }.margin({top:30})

      Column({}){
        TextInput({placeholder:'请输入账号'})
          .margin({top:20})
          .type(InputType.Normal)
          .padding(10)
          .borderRadius(6)
          .onChange((value:string)=>{
            this.registerParams.username =value
          })
        TextInput({placeholder:"请输入密码"})
          .margin({top:20})
          .type(InputType.Password)
          .padding(10)
          .borderRadius(6)
          .onChange((value:string)=>{
            this.registerParams.password =value
          })

        Row({space:5}){
          TextInput({placeholder:"请输入手机号"})
            .onChange((value:string)=>{
              this.phone = value
            })
            .padding(10)
            .borderRadius(6)
            .width('60%')
          Button('获取验证码')
            .type(ButtonType.Normal)
            .backgroundColor($r("app.color.primary"))
            .borderRadius(6)
            .onClick(async()=>{
              try{
                this.verifyCode = await verificationCode()
              }catch(e){
                console.log(e)
              }
            })
        }
        .width('100%')
        .margin({top:20})
        Row(){
          TextInput({placeholder:"请输入验证码"})
            .placeholderFont({size:13})
            .margin({top:20})
            .type(InputType.Normal)
            .width('50%')
            .padding(10)
            .borderRadius(6)
            .onChange((value:string)=>{
              this.registerParams.verification_code =value
            })
          Column({space:4}){
            Text(this.verifyCode.verification_code||"")
              .fontSize(20)
              .fontWeight(700)
              .letterSpacing(6)
              .fontColor($r("app.color.primary"))
            Text('看不清,再次获取验证码')
              .fontSize(13)
              .fontColor($r("app.color.text_secondary"))
              .onClick(async ()=>{
                try{
                  this.verifyCode = await verificationCode()
                  Log.info(JSON.stringify(this.verifyCode))
                }catch(e){
                  console.log(e)
                }
              })
          }
        }
        .width('100%')
        .margin({top:20})

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

        Button(){
          Row({space:10}){
            Image($r("app.media.regis")).width(20).aspectRatio(1)
            Text('注册').fontSize(20)
              .fontColor($r("app.color.white"))
          }
        } .height(47)
        .width('100%')
        .borderRadius(10)
        .type(ButtonType.Normal)
        .margin({top:20})
        .enabled(this.getButtonStatus())
        .backgroundColor(this.getButtonStatus()?$r("app.color.primary"):$r("app.color.primary_disabled"))
        .onClick(async ()=>{
          Log.info(JSON.stringify(this.registerParams))
          try {
            await registerFuncall(this.registerParams)
            router.pushUrl({url:"pages/login/Login"})
          } catch (err) {
            console.log(JSON.stringify(err))
          }
        })
      }.width('100%')
      .padding({left:20,right:20})
    }


    .height('100%')
    .width('100%')

  }
  getButtonStatus(){
    if(this.isSelected &&
    this.registerParams.username
      && this.registerParams.password
      && this.registerParams.verification_code
     && this.phone
    ){
      return true
    }
    return false
  }
}