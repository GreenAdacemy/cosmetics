import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

export default class extends Controller {
  connect() {
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.canvas.dataset.labels),
        datasets: [{
          data: JSON.parse(ctx.canvas.dataset.data),
        }]
      },
    });    
  }
}
