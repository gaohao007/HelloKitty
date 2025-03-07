import { LoginSuccessData, UserLoginParams } from "../model/login";
import { Request_API } from "../utils";


// 获取广告数据
export async  function LoginForm(data:UserLoginParams){
  return await Request_API.post<LoginSuccessData>('login', data)
}