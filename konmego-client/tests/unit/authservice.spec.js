import { expect } from 'chai'
import { authService } from '@/_services/auth.service'


describe('Auth Service', () => {
  it('has local storage', () => {
    
    expect(window.localStorage).to.not.be.null
  })

  describe("currentUser",() => {
    const user  = {first: "herby", last: "plerby"}
    window.localStorage.setItem("user", JSON.stringify(user))
    expect(authService.currentUser()).to.eql(user)
  })
})
