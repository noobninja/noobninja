jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.datetimepicker').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.datetimepicker input[type="text"]', (event) ->
    $(this).parent().parent().find("span.add-on").click()

  $('form').on 'click', '.add_fields', (event) ->
    datetimepicker()

  datetimepicker = ->
    $('.datetimepicker').datetimepicker
      language: 'en'
      pick12HourFormat: true
      pickSeconds: false,
      startDate: new Date()

  datetimepicker()