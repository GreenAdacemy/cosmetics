module OrdersHelper
  def currency(num, cls=nil)
    num == 0.0 ? price_contact : n2c(num, cls)
  end

  def order_progress(cart)
    content_tag :div, class: 'w-100 mt-6 mb-5' do
      content_tag :div, class: 'position-relative w-75 m-auto' do
        content_tag :div, class: 'position-relative w-100 ms-10' do
          concat content_tag(:div, progress_tag(cart), class: 'progress height-1')
          concat content_tag(:div, buttons_tag(cart))
        end
      end
    end
  end

  private
  def price_contact
    content_tag :div, t('orders.price_contact'), class: 'text-capitalize text-danger'
  end

  def n2c(num, cls)
    html = cls.nil? ? '<div>%n<sup>%u</sup></div>' : '<div class="price-order-top">%n<sup>%u</sup></div>'
    number_to_currency(
        num*1000, 
        unit: 'đ', 
        format: html.html_safe, 
        separator: '.', 
        delimiter: ','
      ).gsub(/\.0+\</, '<').html_safe
  end

  def buttons_tag(cart)
    html = ''
    start = 0
    ['in_cart', 'checkout', 'confirm', 'delivering', 'completed'].each do |status|
      html << button_tag(status, active_list(cart.status), start)
      start = start + 20
    end
    html.html_safe
  end

  def button_tag(status, active, start)
    content_tag :button, class: class_names({
      'position-absolute': true,
      'top-0': true,
      'start-0': start == 0,
      'start-20': start == 20,
      'start-40': start == 40,
      'start-60': start == 60,
      'start-80': start == 80,
      'translate-middle': true,
      btn: true,
      'btn-sm': true,
      'btn-success': active.include?(status),
      'btn-secondary': !active.include?(status),
      'rounded-pill': true,
      'button-progress-check': true
    }), type: 'button' do
      concat content_tag(:p, t("orders.#{status}"), class: 'progress-title text-capitalize')
      concat content_tag(:i, nil, class: 'fas fa-check')
    end
  end

  def progress_tag(cart)
    content_tag(
      :div, nil, class: progress_class(cart), 
      role: 'progressbar', 'aria-valuenow': value_now(cart.status), 'aria-valuemin': '0', 
      'aria-valuemax': '100'
    )
  end

  def value_now(status)
    statuses[status.to_sym][:position]
  end

  def active_list(status)
    statuses[status.to_sym][:active]
  end
  
  def statuses
    {
      in_cart: {
        position: 0,
        active: ['in_cart']
      }, 
      checkout: {
        position: 20,
        active: ['in_cart', 'checkout']
      },
      confirm: {
        position: 40,
        active: ['in_cart', 'checkout', 'confirm']
      },
      delivering: {
        position: 60,
        active: ['in_cart', 'checkout', 'confirm', 'delivering']
      },
      completed: {
        position: 80,
        active: ['in_cart', 'checkout', 'confirm', 'delivering', 'completed']
      }
    }
  end

  def progress_class(cart)
    class_names({
      'progress-bar': true,
      'bg-success': true,
      'in-cart': cart.status == 'in_cart',
      checkout: cart.status == 'checkout',
      confirm: cart.status == 'confirmed',
      delivering: cart.status == 'delivering',
      completed: cart.status == 'completed',
      closed: cart.status == 'closed'
    })
  end
end