import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

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
    const self = this
    const href = Routes.order_line_item_path(
      target.getAttribute('data-order'),
      target.getAttribute('data-product'),
    )
    fetch(
      href, {
        method: 'PUT',
        "Content-Type": "application/json",
        credentials: 'same-origin',
        headers: {
          "X-CSRF-Token": self.csrfToken(),
          Accept: "text/vnd.turbo-stream.html",
        },
        body: this.initFormData('add')
      }
    )
      .then(r => r.text())
      .then(data => {
        console.log(data)
        // data = JSON.parse(data)
        // const cart = document.querySelector('.cart')
        // cart.setAttribute('data-label', data.badge)
        // if (data.badge > 9) {
        //   cart.classList.remove('one-unit')
        // } else {
        //   cart.classList.add('one-unit')
        // }
      })
  }

  like(target) {
    console.log('like:', target)
  }

  csrfToken() {
    return document.querySelector("[name='csrf-token']").content
  }

  initFormData(addMore) {
    let data = new FormData()
    data.append('order', JSON.stringify({
      type: addMore
    }))
    return data
  }
}
