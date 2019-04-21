import { expect } from 'chai'
import { authService, SESSION_USER_KEY as AUTH_SVC_SESSION_USER_KEY, SESSION_AUTH_KEY as AUTH_SVC_SESSION_TOKEN_KEY, __RewireAPI__ as apiServiceRewireApi } from '@/_services/auth.service'

const { localStorage, sessionStorage } = window
const user = { first: "herby", last: "plerby" }
const session_jwt = "eyJhbGciOiJIUzI1NiJ9.eyJ1aWQiOjIsImZpcnN0IjoiSGVyYnkiLCJsYXN0IjoiUmF5bmF1ZCIsImV4cCI6MTU1NTkwMzcyOH0.R8ObE0AMRyhkes7gwjWX2Vd9B0WitUx0fnccJGuSDKI";
const mockApiService = {};

beforeEach(function () {
  apiServiceRewireApi.__Rewire__('apiService', mockApiService);
})

afterEach(function () {
  localStorage.clear()
  sessionStorage.clear()
  apiServiceRewireApi.__ResetDependency__('apiService');
})

describe('Auth Service', () => {
  it("works ", function () {

    describe("currentUser", () => {
      it("finds user", () => {
        localStorage.setItem(AUTH_SVC_SESSION_USER_KEY, JSON.stringify(user));
        expect(authService.currentUser()).to.eql(user);
      })
    })

    describe("logout", () => {
      it("logs user out", () => {
        localStorage.setItem(AUTH_SVC_SESSION_USER_KEY, JSON.stringify(user))
        sessionStorage.setItem(AUTH_SVC_SESSION_TOKEN_KEY, "This is encrypted")
        expect(sessionStorage.getItem(AUTH_SVC_SESSION_TOKEN_KEY)).to.eql("This is encrypted")
        expect(JSON.parse(localStorage.getItem(AUTH_SVC_SESSION_USER_KEY))).to.eql(user)

        authService.logout()

        expect(sessionStorage.getItem(AUTH_SVC_SESSION_TOKEN_KEY)).to.be.null;
        expect(localStorage.getItem(AUTH_SVC_SESSION_USER_KEY)).to.be.null;
      })
    })

    describe('login', () => {

      it('stores user in session when successful', () => {
        mockApiService.writeToApi = function (path, data) {
          return Promise.resolve({
            data: {
              jwt: session_jwt
            }
          })
        }
        return authService.login("herby", "test")
          .then(() => {
            expect(sessionStorage.getItem(AUTH_SVC_SESSION_TOKEN_KEY)).to.not.be.null;
            expect(sessionStorage.getItem(AUTH_SVC_SESSION_TOKEN_KEY)).to.eql(session_jwt);
          })
      });

      it('throws an error on auth failure', () => {
        mockApiService.writeToApi = function (path, data) {
          return Promise.reject({
            response: { data: { error: "Wrong credentials bro" } }
          })
        }

        return authService.login("herby", "test")
          .catch((error) => {
            expect(error.response.data.error).to.equal("Wrong credentials bro")
            expect(sessionStorage.getItem(AUTH_SVC_SESSION_TOKEN_KEY)).to.be.null
          })
      });
    })
  });
})