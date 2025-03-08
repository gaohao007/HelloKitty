import { UserInfo } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function getUserInfo(id:number){
  return await Request_API.get<UserInfo>(`api/users/${id}`)
}