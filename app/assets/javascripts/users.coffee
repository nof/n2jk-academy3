$ ->
  $('.js-posts-link').click ->
    window.location = $(@).data('url')
