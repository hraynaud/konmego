import { expect } from 'chai'
import { authService } from '@/_services'
//import sinon from 'sinon'

const { localStorage, sessionStorage } = window
const user = { first: "herby", last: "plerby" }

// sinon.stub(apiService, 'writeToApi').returns(Promise.resolve({
//   response: {
//     data: {
//       jwt: "This is a jwt"
//     }
//   }
// }));

describe('Auth Service', () => {
  it('has local storage', () => {
    expect(localStorage).to.not.be.null
  })

  describe("currentUser", () => {
    it("finds user", () => {
      localStorage.setItem("user", JSON.stringify(user));
      expect(authService.currentUser()).to.eql(user);
    })
  })

  describe("logout", () => {
    it("logs user out", () => {
      localStorage.setItem("user", JSON.stringify(user))
      sessionStorage.setItem("jwt", "This is encrypted")
      expect(sessionStorage.getItem("jwt")).to.eql("This is encrypted")
      expect(JSON.parse(localStorage.getItem("user"))).to.eql(user)

      authService.logout()

      expect(sessionStorage.getItem("jwt")).to.be.null;
      expect(localStorage.getItem("user")).to.be.null;
    })
  })

  // describe("login", () => {

  //   authService.login(user)
  //   expect(sessionStorage.getItem("jwt")).to.not.be.null
  //   expect(localStorage.getItem("user")).to.not.be.null
  // })
})