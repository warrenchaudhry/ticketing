shortWords = Ember.A ['of','a','the','and','an','or','nor','but','is','if','then','else','when','at','from','by','on','off','for','in','out','over','to','into','with']

titleize = (str) ->
  strArray = str.split ' '
  strArray = Ember.ArrayPolyfills.map.call strArray, (slug) ->
    if index is 0 or not shortWords.contains(slug)
      Ember.String.capitalize slug
    else slug
  strArray.join ' '

Ember.Handlebars.registerBoundHelper 'titleize', titleize
