import { Controller } from "@hotwired/stimulus"
import { product_path } from '../routes';

// Connects to data-controller="product"
export default class extends Controller {
  connect() {
  }

  viewDetail(event) {
    console.log('--------------------------')
    console.info(event.currentTarget)
    const id = event.currentTarget.getAttribute('data-id')
    console.info(Routes.product_path(id))
    console.log(history)
    location.href = Routes.product_path(id)
    console.log('--------------------------')
  }
}
