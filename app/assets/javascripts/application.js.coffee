#= require jquery
#= require jquery_ujs
#= require foundation
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