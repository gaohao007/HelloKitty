@Entry
@Component
struct User {
  @State message: string =
    '{"connection":"close","content-length":"71","content-type":"application/json","date":"Thu, 06 Mar 2025 09:52:47 GMT","server":"Werkzeug/3.1.3 Python/3.12.6","vary":"Cookie","set-cookie":["session=.eJyrVipLLcpMy0xOLMnMz4tPzk9JVbJSMra0NDM2V9LBlIwvycwFqTAyMDLVNTDWNTBTMDS3MjWyMjFXqgUA8dwXsA.Z8lwbw.I6UfJfqQNqvKh0TQxIvJGCAlRSU; HttpOnly; Path=/"]}';
aboutToAppear(): void {
      JSON.parse(this.message)
}
  build() {
    RelativeContainer() {
      Text(this.message)
        .id('UserHelloWorld')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}