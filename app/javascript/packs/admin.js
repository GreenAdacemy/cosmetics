import '../stylesheets/admin'

require("./nested-forms/addFields")
require("./nested-forms/removeFields")

import lozad from 'lozad'
document.addEventListener('turbolinks:load', function(){
    lozad().observe()
})