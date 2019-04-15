import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import HomePage from '@/home/HomePage.vue'

describe('HomePage.vue', () => {
  it('renders props.user when passed', () => {
    const user = 'Herby'
    const wrapper = shallowMount(HomePage, {
      propsData: { user }
    })
    expect(wrapper.text()).to.include(user)
  })
})
