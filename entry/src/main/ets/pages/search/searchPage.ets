import { NavBar } from '../../component'
import { APP_TOP_HEIGHT } from '../../constans'
import { PerferenceHelpe } from '../../utils'

@Entry
@Component
struct SearchPage {
  @State searchText:string=""
  @State searchHistory:string[]=[]
  @State searchResult:string[]=[]
  @State value:string=""
  @State isDelete:boolean=true
 async  aboutToAppear() {
      const res = await new PerferenceHelpe(getContext(this)).getSearchText()
      if(res){
        this.searchHistory=res
        if (this.searchHistory.length<=4) {
          this.searchResult = this.searchHistory
        }else {
          this.searchResult = this.searchHistory.slice(0,4)
        }
      }
  }
  build() {
    Column(){
      Row().width('100%')
        .height(AppStorage.get(APP_TOP_HEIGHT))
        .backgroundColor($r("app.color.white"))
       NavBar({title:"搜索"})
      Text("今天想找什么?").width('100%')
        .padding({left:20})
        .margin({top:20})
        .fontSize(26)
        .fontWeight(700)
        .letterSpacing(5)


      Row({space:10}){
        TextInput({placeholder:"万千好物等你搜索",text:this.value})
          .backgroundColor($r("app.color.white"))
          .width('60%')
          .borderRadius(0)
          .border({width:{bottom:1},color:$r("app.color.background_divider")})
          .onChange((value:string)=>{
            this.searchText=value
            this.value=value
          })
        Image($r("app.media.sousuo")).aspectRatio(1).width(30)
          .onClick(async ()=>{
            if(this.searchText){
              this.searchHistory.unshift(this.searchText)
              await new PerferenceHelpe(getContext(this)).setSearchText(this.searchHistory)
              if (this.searchHistory.length<=4) {
                this.searchResult = this.searchHistory
              }else {
                this.searchResult = this.searchHistory.slice(0,4)
              }
              this.value=""
            }
          })
      }.width('100%')
      .margin({top:20})
      .padding({left:20})
      Row(){
        Text('历史记录').fontSize(12)
          .fontColor($r("app.color.text_secondary"))
        Blank()
        if (this.isDelete){
          Image( $r("app.media.trash")).aspectRatio(1).width(24)
            .onClick(()=>{
              this.isDelete = false
            })
        }else {
          Text('全部删除')
            .fontSize(12)
            .fontColor($r("app.color.text_secondary"))
            .onClick(async ()=>{
              this.searchHistory=[]
              await new PerferenceHelpe(getContext(this)).setSearchText(this.searchHistory)
              this.searchResult=[]
              this.isDelete = true
            })
            .border({width:{right:1},color:$r("app.color.background_divider")})
            .margin({right:10})
          Text('完成')
            .fontSize(12)
            .fontColor($r("app.color.text_secondary"))
            .onClick(()=>{
              this.isDelete = true
            })
        }
      }.width('100%').padding({left:20,right:20})
      .margin({top:10,bottom:10})

        Flex({wrap:FlexWrap.Wrap,direction:FlexDirection.Row}){
        ForEach(this.searchResult,(item:string,index:number)=>{
          Text(item)
            .padding(10)
            .border({width:1,color:$r("app.color.background_divider"),radius:6})
            .margin({left:10,top:10})
            .constraintSize({minWidth:60,maxWidth:150})
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .textAlign(TextAlign.Center)
            .onClick(()=>{
              this.value=item
            })
        })

        }.width('100%').padding({left:20})

    }
    .height('100%')
    .width('100%')
  }
}