import {  AdvertiseDataModel } from "../model";
import { Request_API } from "../utils";

// 获取广告数据
export async  function getAdvertiseData(){
  return await Request_API.get<AdvertiseDataModel>('/api/advertisements')
}