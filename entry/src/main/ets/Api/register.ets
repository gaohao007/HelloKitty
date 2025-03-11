import { RegisterParams, VerificationCode } from "../model";
import { Request_API } from "../utils";


// 获取广告数据
export async  function verificationCode(){
  return await Request_API.get<VerificationCode>('get_verification_code')
}

// 获取广告数据
export async  function registerFuncall(data:RegisterParams){
  return await Request_API.post<null>( 'register' , data )
}

