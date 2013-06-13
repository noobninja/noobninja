jQuery ->
  $('.select2-select').select2
    placeholder: "Select a Tag",
    allowClear: true

  $('.select2-select').on 'change', (e) ->
    type = $.url(location.href).param('type')
    if (type == undefined && e.val.length == 0)
      window.location = "/"
    else if type == undefined
      window.location = "?tag=" + e.val
    else if e.val.length == 0
      window.location = "?type=" + type
    else
      window.location = "?type=" + type + "&tag=" + e.val