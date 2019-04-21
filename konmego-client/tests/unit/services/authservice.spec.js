import { expect } from 'chai'
import { authService, __RewireAPI__ as apiServiceRewireApi } from '@/_services/auth.service'

const { localStorage, sessionStorage } = window
const user = { first: "herby", last: "plerby" }

afterEach(function () {
  localStorage.clear()
  sessionStorage.clear()
})

describe('Auth Service', () => {
  it("works ", function () {

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

    describe('login', () => {

      it('should log user in', () => {
        const mockApiService = {
          writeToApi: function (path, data) {
            return Promise.resolve({
              data: {
                jwt: "eyJhbGciOiJIUzI1NiJ9.eyJ1aWQiOjIsImZpcnN0IjoiSGVyYnkiLCJsYXN0IjoiUmF5bmF1ZCIsImV4cCI6MTU1NTkwMzcyOH0.R8ObE0AMRyhkes7gwjWX2Vd9B0WitUx0fnccJGuSDKI"
              }
            })
          }
        };

        apiServiceRewireApi.__Rewire__('apiService', mockApiService);

        return authService.login("herby", "test")
          .then(() => {
            expect(sessionStorage.getItem("jwt")).to.not.be.null;
            expect(sessionStorage.getItem("jwt")).to.eql('eyJhbGciOiJIUzI1NiJ9.eyJ1aWQiOjIsImZpcnN0IjoiSGVyYnkiLCJsYXN0IjoiUmF5bmF1ZCIsImV4cCI6MTU1NTkwMzcyOH0.R8ObE0AMRyhkes7gwjWX2Vd9B0WitUx0fnccJGuSDKI');
            apiServiceRewireApi.__ResetDependency__('apiService');
          })
      });

      it('should fail log user in', () => {
        const mockApiService = {
          writeToApi: function (path, data) {
            return Promise.reject({
              response: { data: { error: "Wrong credentials bro" } }
            })
          }
        };

        apiServiceRewireApi.__Rewire__('apiService', mockApiService);

        return authService.login("herby", "test")
          .catch((error) => {
            expect(sessionStorage.getItem("jwt")).to.be.null
          })

      });
    })
  });
})

