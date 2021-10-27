import lozad from "lozad"

function reLoadLozad() {
  lozad().observe()
}

export function start() {
  reLoadLozad()
  window.addEventListener('reload', function () {
    reLoadLozad()
  })  
}