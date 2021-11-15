class checkOnlyPrimary {
  constructor() {
    this.iterateOnlyPrimary()
  }

  iterateOnlyPrimary() {
    document.addEventListener("click", (e) => {
      if(e.target && e.target.className == 'custom-control-input') {
        const nodes = document.querySelectorAll('.custom-checkbox')
        nodes.forEach(function(element) {
          const id = element.querySelector('.custom-control-input').getAttribute('id')
          if(id != e.target.getAttribute('id')) {
            element.querySelector('.custom-control-input').checked = false
          }
        })
      }
    })
  }
}

window.addEventListener("turbolinks:load", () => new checkOnlyPrimary());
