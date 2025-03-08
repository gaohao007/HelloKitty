import { Context } from "@kit.AbilityKit"
import { preferences } from "@kit.ArkData"
import { ADDRESSID, ADVERTISEMNET_KEY, ADVERTISE_KEY, COOKIE, USER_ID, USER_INFO } from "../constans"
import { AdvertiseData, AdvertiseDataModel, AdvertiseitemModel, UserInfo, UserInfoModel } from "../model"

const defaultad:AdvertiseDataModel = new AdvertiseDataModel({
  isshow:true,
  showTime:10,
  items:[
    new AdvertiseitemModel({
      description: "灵感穿搭1折起",
      id: 1,
      image: "static/images/advertise/i1.jpg"
    })
  ]
})

export class  PerferenceHelpe{
  context:Context

  constructor(context:Context) {
    this.context = context
  }

  getStore(){
    return preferences.getPreferences(this.context,ADVERTISEMNET_KEY)
  }

//启动页广告
  async SetStartPage(advertise:AdvertiseData){
    const store = await this.getStore()
    store.put(ADVERTISE_KEY,JSON.stringify(advertise))
    store.flush()
  }

  //取广告数据
  async getAdvertiseData():Promise<AdvertiseDataModel>{
    const store = await this.getStore()
    const str = await store.get(ADVERTISE_KEY,JSON.stringify(defaultad)) as string
    return JSON.parse(str) as AdvertiseDataModel
  }
  //针对userid
  async setUserID(id:number){
    const store = await this.getStore()
    store.put(USER_ID,id)
    store.flush()
  }

  async  getUserID():Promise<number>{
    const store = await this.getStore()
    const  str:number = await store.get(USER_ID,0) as number
    return  str
  }


  async setCookie(str:string){
    const store = await this.getStore()
    store.put(COOKIE,str)
    store.flush()
  }

  async  getCookie():Promise<string>{
    const store = await this.getStore()
    const  str = await store.get(COOKIE,'') as string
    return  str
  }


  async setUserInfo(userInfo:UserInfo){
    const store = await this.getStore()
    store.put(USER_INFO,JSON.stringify(userInfo))
    store.flush()
  }

  async getUserInfo():Promise<UserInfo>{
    const store = await this.getStore()
    const  userInfo = await store.get(USER_INFO,JSON.stringify(new UserInfoModel({} as UserInfo))) as string
    return JSON.parse(userInfo) as UserInfo
  }

  async setAddressID(id:number){
    const store = await this.getStore()
    store.put(ADDRESSID,id)
    store.flush()
  }

  async getAddressID():Promise<number>{
    const store = await this.getStore()
    const  id = await store.get(ADDRESSID,0) as number
    return id
  }

}