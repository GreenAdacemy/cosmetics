// import '../stylesheets/admin'

// require("./nested-forms/addFields")
// require("./nested-forms/removeFields")
// require("./nested-forms/primary")

import lozad from 'lozad'
document.addEventListener('turbolinks:load', function(){
  lozad().observe()
})

const images = require.context("../images", true)

import '../stylesheets/admin.scss'

require("./nested-forms/addFields")
require("./nested-forms/removeFields")
require("./nested-forms/primary")