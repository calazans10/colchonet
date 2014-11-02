$ ->
  $review = $('.review')
  $star = $('.review input:checked + label')
  $stars = $('.review input:enabled ~ label')

  $review.on 'ajax:beforeSend', ->
    $(this).find('input').attr 'disabled', true

  $review.on 'ajax:error', ->
    replaceButton $(this), 'fa fa-times', '#B94A48'

  $review.on 'ajax:success', ->
    replaceButton $(this), 'fa fa-check', '#468847'

  $stars.on 'mouseenter', ->
    highlightStars $(this)

  $stars.on 'mouseleave', ->
    highlightStars $star

  $('.review input').on 'change', ->
    $stars.off('mouseenter').off('mouseleave').off('click')
    $(this).parent('form').submit()

  replaceButton = (container, icon_class, color) ->
    icon = $('<i/>').addClass(icon_class).css('color', color)
    container.find('input:submit').replaceWith icon

  highlightStars = (elem) ->
    elem.parent().children('label').removeClass 'toggled'
    elem.addClass('toggled').prevAll('label').addClass('toggled')

  highlightStars $star
