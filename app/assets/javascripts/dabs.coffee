# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bell = new Howl({
  urls: [
    'https://s3.amazonaws.com/glassy-collections/sounds/bell.webm',
    'https://s3.amazonaws.com/glassy-collections/sounds/bell.ogg',
    'https://s3.amazonaws.com/glassy-collections/sounds/bell.mp3'
  ]
})

started_at = null
ends_at = null

start_timer = (duration)->
  started_at = moment()
  ends_at = started_at.add(duration, 's')
  $('.timer .seconds').text(duration)
  $('.timer').show();
  refresh_seconds();

reset_background = ->
  $('html').css('background', '')

timer_finished = ->
  seconds = $('.timer .seconds')
  seconds.text(0)
  bell.play()
  $('a.take-a-dab').addClass('done')
  $('html').css('background', 'red')
  setTimeout(reset_background, 5000)

  $('form.new_dab').addClass('post-dab')
  $('.timer').hide();

refresh_seconds = ->
  seconds = $('.timer .seconds')
  now = moment()
  remaining_milli = (ends_at - now)
  if remaining_milli > 0
    seconds.text((remaining_milli / 1000.0).toFixed(1))
    setTimeout(refresh_seconds, 50)
  else
    timer_finished()

$('html').on 'change', 'form.new_dab input#dab_seconds', (event)->
  seconds = $('form.new_dab input#dab_seconds')
  milliseconds = $('form.new_dab input#dab_milliseconds')
  milliseconds.val(parseFloat(seconds.val())*1000)

$('html').on 'click', 'button#start-timer', (event)->
  seconds = $('form.new_dab input#dab_seconds')
  $('.timer-form').hide()

  start_timer(parseFloat(seconds.val()))
