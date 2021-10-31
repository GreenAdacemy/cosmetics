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
    const href = Routes.order_line_items_path(target.getAttribute('data-order'))
    // console.info(this.initFormData(target))
    // Rails.ajax({
    //   type: 'POST',
    //   url: href,
    //   data: this.initFormData(target),
    //   dataType: 'json'
    // })
    fetch(
      href, {
        method: 'POST',
        "Content-Type": "application/json",
        credentials: 'same-origin',
        headers: {
          "X-CSRF-Token": self.csrfToken(),
          Accept: "text/vnd.turbo-stream.html",
        },
        data: this.initFormData(target)
      }
    )
      .then(r => r.text())
      .then(html => console.log(html))
  }

  like(target) {
    console.log('like:', target)
  }

  csrfToken() {
    return document.querySelector("[name='csrf-token']").content
  }

  initFormData(target) {
    const line_item_params = {
      id: target.getAttribute('data-id'),
      slug: target.getAttribute('data-product')
    }
    let data = new FormData()
    data.append('product', JSON.stringify(line_item_params))
    return data
    // return order_params
  }
}
