# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bell = new Howl({
  urls: ['assets/bell.mp3']
})

refresh_seconds = ->
  seconds = $('.dab .seconds')
  started_at = moment.unix(parseFloat($('.dab').attr('data-created-at-time')))
  ends_at = moment.unix(parseFloat($('.dab').attr('data-ends-at-time')))
  now = moment()
  remaining_milli = (ends_at - now)
  if remaining_milli > 0
    seconds.text(remaining_milli / 1000.0)
    setTimeout(refresh_seconds, 10)
  else
    seconds.text(0)
    bell.play();


root = exports ? this
root.start_dab_timer = ->
  refresh_seconds()
