jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  membership.setupForm()

  $('#membership_plan_id_1').on 'click', ->
      $('.membership_footer p').html('Your card won"t be charged upon submission of this form.')

  $('#membership_plan_id_2').on 'click', ->
      $('.membership_footer p').html('Your card will be charged $20 upon submission of this form.')

  $('#membership_plan_id_3').on 'click', ->
      $('.membership_footer p').html('Your card will be charged $120 upon submission of this form.')

  $('.new_membership #membership_plan_id_1').on 'click', ->
      $('input[type="submit"]').attr("value", "VERIFY ACCOUNT")

  $('.new_membership #membership_plan_id_2, .new_membership #membership_plan_id_3').on 'click', ->
      $('input[type="submit"]').attr("value", "START SUBSCRIPTION")



membership =
  setupForm: ->
    $('#new_membership').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        membership.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, membership.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#membership_stripe_card_token').val(response.id)
      $('#new_membership')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)