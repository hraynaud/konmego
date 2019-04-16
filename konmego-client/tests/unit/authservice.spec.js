import { expect } from 'chai'
import { authService } from '@/_services/auth.service'
const {localStorage} = window

describe('Auth Service', () => {
  it('has local storage', () => {
    expect(localStorage).to.not.be.null
  })

  describe("currentUser",() => {
    const user  = {first: "herby", last: "plerby"}
    localStorage.setItem("user", JSON.stringify(user))
    expect(authService.currentUser()).to.eql(user)
  })
})
