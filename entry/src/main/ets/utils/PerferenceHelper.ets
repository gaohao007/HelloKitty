import { Context } from "@kit.AbilityKit"
import { preferences } from "@kit.ArkData"
import { ADVERTISEMNET_KEY, ADVERTISE_KEY } from "../constans"
import { AdvertiseData, AdvertiseDataModel, AdvertiseitemModel } from "../model"

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















}