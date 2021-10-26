import { Controller } from "@hotwired/stimulus"
import lozad from "lozad"

export default class extends Controller {
  static targets = ['main']
  static lozadLoaded = false

  connect() {
  }

  mainTargetConnected() {
    if (!this.lozadLoaded) {
      this.loadLozad()
    }
  }

  mainTargetDisconnected() {
    this.lozadLoaded = false
  }

  loadLozad() {
    window.dispatchEvent(new Event('reload'))
  }

  disconnect() {
  }

  reconnect() {
    this.loadLozad()
  }

  initialize() {
  }
}