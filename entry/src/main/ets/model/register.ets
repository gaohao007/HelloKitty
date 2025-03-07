
export interface VerificationCode{
  verification_code: string
}
export class VerificationCodeModel implements VerificationCode{
  verification_code: string
  constructor(data:VerificationCode){
    this.verification_code = data.verification_code
  }
}

export interface RegisterParams{

  username: string
  password: string
  verification_code:string
}

export class RegisterParamsModel implements RegisterParams{
  username: string
  password: string
  verification_code:string
  constructor(data:RegisterParams){
    this.username = data.username
    this.password = data.password
    this.verification_code = data.verification_code
  }
}

