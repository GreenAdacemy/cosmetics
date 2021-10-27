import { Controller } from "@hotwired/stimulus"
import Splide from "@splidejs/splide"

export default class extends Controller {
  static targets = [ 'splide' ]
  connect() {
    this.initSplide()
  }

  initSplide() {
    let id = this.splideTarget.getAttribute('id')
    let splide = new Splide(`#${id}`, this.options())
    if(splide){
      splide.mount()
    }
  }

  options() {
    return {
      autoplay: false,
      type: 'loop',
      lazyLoad: 'nearby',
      cover: true,
      arrows: false,
      pagination: false
    }
  }
}