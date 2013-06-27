#= require jquery
#= require jquery_ujs
#= require foundation
#= require autosize.min
#= require select2.min
#= require purl

jQuery ->
  $(document).foundation()

  # Select2 Time Zone
  if $('#user_time_zone').length
    $('#user_time_zone').select2()

  # Welcome tagline
  if $('.pitch').length
    setInterval( () ->
      $('.pitch h1 span').fadeOut( ()->
        if $(this).html().search('Get helped') == 0
          $(this).html('Help others').fadeIn('slow')
        else
          $(this).html('Get helped').fadeIn('slow')
      )
    , 7500)

  $('textarea').autosize()
  # $('.alert-box').delay(8000).slideToggle('slow')
  $('.user-show-description').on 'click', (e)->
    $('.user-description').slideToggle()

  $('.why-hangouts').on 'click', (e) ->
    $('.why-hangouts-hidden').slideToggle()
