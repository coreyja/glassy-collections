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
    $('a.take-a-dab').addClass('done')


root = exports ? this
root.start_dab_timer = ->
  refresh_seconds()

$('html').on 'change', 'form.new_dab select#dab_nail_id', (event)->
  select = $('form.new_dab select#dab_nail_id')
  avg = $('form.new_dab input#nail_avg_' + select.val()).val()
  avg = parseFloat(avg)
  $('form.new_dab input#dab_seconds').val(avg / 1000.0)
  $('form.new_dab input#dab_seconds').change()

$('html').on 'change', 'form.new_dab input#dab_seconds', (event)->
  seconds = $('form.new_dab input#dab_seconds')
  milliseconds = $('form.new_dab input#dab_milliseconds')
  milliseconds.val(parseFloat(seconds.val())*1000)
