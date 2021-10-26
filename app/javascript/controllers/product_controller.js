import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  connect() {
    console.log('connect product')
  }

  viewDetail(event) {
    console.info(event.currentTarget)
  }
}
