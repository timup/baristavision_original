source = new EventSource('/orders')

source.onmessage = (event) ->
  alert "It worked!!"
  $('#orders').find('.order-list').prepend($.parseHTML(event.data))


# dropdown menu

$(document).ready ->
  $(".dropdown-button").click ->
    $button = $(this)
    $menu = $button.siblings(".dropdown-menu")
    $menu.toggleClass "show-menu"
    $menu.children("li").click ->
      $menu.removeClass "show-menu"
      $button.html $(this).html()
      return
    return
  return
