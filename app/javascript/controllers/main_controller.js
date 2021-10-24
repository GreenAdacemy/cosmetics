import { Controller } from "@hotwired/stimulus"
import lozad from "lozad"

export default class extends Controller {
  static targets = ['main']
  static lozadLoaded = false

  connect() {
    // this.loadDefault()
  }

  mainTargetConnected() {
    if (!this.lozadLoaded) {
      this.loadDefault()
    }
  }

  mainTargetDisconnected() {
    this.lozadLoaded = false
  }

  loadDefault() {
    console.info('Enable lazy load')
    lozad().observe()
    this.lozadLoaded = true
  }

  disconnect() {
    console.info('disconnect')
  }

  reconnect() {
    console.log('call reconnect')
    this.loadDefault()
  }

  initialize() {
    console.log('init')
    document.addEventListener('cable-ready:after-morph', this.reconnect.bind(this))    
    // document.addEventListener(
    //   "turbo:frame-render",
    //   this.reconnect.bind(this)
    // );
  }
}