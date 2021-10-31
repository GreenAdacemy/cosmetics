import { Controller } from "@hotwired/stimulus"
import { product_path } from '../routes';

// Connects to data-controller="product"
export default class extends Controller {
  connect() {
  }

  viewDetail(event) {
    event.preventDefault()
    event.stopPropagation()
    const id = event.currentTarget.getAttribute('data-id')
    location.href = Routes.product_path(id)
  }

  action(event) {
    event.preventDefault()
    event.stopPropagation()
    const target = event.currentTarget
    const type = target.getAttribute('data-type')
    switch (type) {
      case 'add2cart':
        this.add2cart(target)
        break
      case 'like':
        this.like(target)
        break
    }
  }

  add2cart(target) {    
    console.log(target)
  }

  like(target) {
    console.log('like:', target)
  }
}
