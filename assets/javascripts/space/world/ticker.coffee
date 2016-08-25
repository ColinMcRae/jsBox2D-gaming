angular.module('Space')
  .service 'ticker', () ->
    l = this
    w_loop = undefined

    this.tick = () ->
      console.log 'tick'

    this.startWorld = () ->
      clearInterval w_loop
      w_loop = setInterval(l.tick, 1000 / 60)
    return
