class Wifi

  constructor: ->
    @keyboard = {
      shift: false,
      capslock: false
    }

wifi = new Wifi

$(document).on 'click', '#keyboard li', ->
  $write = $('#write')
  $this = $(this)
  character = $this.html()
  if ($this.hasClass('left-shift') || $this.hasClass('right-shift'))
    $('.letter').toggleClass('uppercase')
    $('.symbol span').toggle()
    if wifi.keyboard.shift
      wifi.keyboard.shift = false
    else
      wifi.keyboard.shift = true
    wifi.keyboard.capslock = false
    return false
  if ($this.hasClass('capslock'))
    $('.letter').toggleClass('uppercase')
    wifi.keyboard.capslock = true
    return false
  if ($this.hasClass('delete'))
    html = $write.val()
    $write.val(html.substr(0, html.length - 1))
    return false
  if ($this.hasClass('enter'))
    console.log 'ok'
    return false
  if ($this.hasClass('symbol')) then character = $('span:visible', $this).html()
  if ($this.hasClass('space')) then character = ' '
  if ($this.hasClass('tab')) then character = "\t"
  if ($this.hasClass('return')) then character = "\n"
  if ($this.hasClass('uppercase')) then character = character.toUpperCase()
  if (wifi.keyboard.shift)
    console.log 'ok'
    $('.symbol span').toggle()
    if (wifi.keyboard.capslock == false) then $('.letter').toggleClass('uppercase')
    wifi.keyboard.shift = false
  $write.val($write.val() + character);
