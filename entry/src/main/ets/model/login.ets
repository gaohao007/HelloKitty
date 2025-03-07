export interface UserLoginParams{
  username:string
  password: string
}
export class UserLoginParamsModel implements UserLoginParams{
  username:string=''
  password: string=''

  constructor(model:UserLoginParams) {
    this.username = model.username
    this.password = model.password
  }
}

export interface LoginSuccessData{
  user_id: number
}
export class LoginSuccessDataModel implements  LoginSuccessData{
  user_id: number=0

  constructor(model:LoginSuccessData) {
    this.user_id = model.user_id
  }
}
