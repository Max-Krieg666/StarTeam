$(document).ready ->
  if $('.line_up_block').length > 0
    team_setter()

team_setter = ->
  team_id = $('.line_up_block')[0].id
  url = '/teams/' + team_id + '/get_players'
  $.ajax url,
    type: 'GET',
    dataType: 'json'
    success: (data) ->
      players = data['players']

      players.forEach (player) ->
        pl_id = player.id


#
# ТЕМП: старая логика, dropdown
#
team_setter_dropdown = ->
  team_id = $('.line_up_block')[0].id
  url = '/teams/' + team_id + '/get_players'
  $.ajax url,
    type: 'GET',
    dataType: 'json'
    success: (data) ->
      players = data['players']
      # dropZone = document.querySelector('#dropZone')
      # dropZone.addEventListener('dragenter', dragEnter, false)
      # dropZone.addEventListener('dragleave', dragLeave, false)
      # dropZone.addEventListener('dragover', dragOver, false)
      # dropZone.addEventListener('drop', dragDrop, false)

      players.forEach (player) ->
        pl_id = player.id
        if pl_id != ''
          obj = document.getElementById(pl_id)
          DragManager.onDragCancel = (obj) ->
            obj.player.rollback()
            return

          DragManager.onDragEnd = (obj, dropElem) ->
            # obj.elem.style.display = 'none'
            # dropElem.classList.add 'computer-smile'
            # setTimeout (->
            #   dropElem.classList.remove 'computer-smile'
            #  return
            #), 200
            return

DragManager = new (->
  # составной объект для хранения информации о переносе:
  # {
  #   elem - элемент, на котором была зажата мышь
  #   player - аватар
  #   downX/downY - координаты, на которых был mousedown
  #   shiftX/shiftY - относительный сдвиг курсора от угла элемента
  # }
  dragObject = {}
  self = this

  onMouseDown = (e) ->
    if e.which != 1
      return
    elem = e.target.closest('.draggable')
    if !elem
      return
    dragObject.elem = elem
    # запомним, что элемент нажат на текущих координатах pageX/pageY
    dragObject.downX = e.pageX
    dragObject.downY = e.pageY
    false

  onMouseMove = (e) ->
    if !dragObject.elem
      return
    # элемент не зажат
    if !dragObject.player
      # если перенос не начат...
      moveX = e.pageX - (dragObject.downX)
      moveY = e.pageY - (dragObject.downY)
      # если мышь передвинулась в нажатом состоянии недостаточно далеко
      if Math.abs(moveX) < 3 and Math.abs(moveY) < 3
        return
      # начинаем перенос
      dragObject.player = createPlayer(e)
      # создать аватар
      if !dragObject.player
        # отмена переноса, нельзя захватить за эту часть элемента
        dragObject = {}
        return
      # аватар создан успешно
      # создать вспомогательные свойства shiftX/shiftY
      coords = getCoords(dragObject.player)
      dragObject.shiftX = dragObject.downX - (coords.left)
      dragObject.shiftY = dragObject.downY - (coords.top)
      startDrag e
      # отобразить начало переноса
    # отобразить перенос объекта при каждом движении мыши
    dragObject.player.style.left = e.pageX - (dragObject.shiftX) + 'px'
    dragObject.player.style.top = e.pageY - (dragObject.shiftY) + 'px'
    false

  onMouseUp = (e) ->
    if dragObject.player
      # если перенос идет
      finishDrag e
    # перенос либо не начинался, либо завершился
    # в любом случае очистим "состояние переноса" dragObject
    dragObject = {}
    return

  finishDrag = (e) ->
    dropElem = findDroppable(e)
    if !dropElem
      self.onDragCancel dragObject
    else
      self.onDragEnd dragObject, dropElem
    return

  createPlayer = (e) ->
    # запомнить старые свойства, чтобы вернуться к ним при отмене переноса
    player = dragObject.elem
    old =
      parent: player.parentNode
      nextSibling: player.nextSibling
      position: player.position or ''
      left: player.left or ''
      top: player.top or ''
      zIndex: player.zIndex or ''

    # функция для отмены переноса
    player.rollback = ->
      old.parent.insertBefore player, old.nextSibling
      player.style.position = old.position
      player.style.left = old.left
      player.style.top = old.top
      player.style.zIndex = old.zIndex
      return

    player

  startDrag = (e) ->
    player = dragObject.player
    # инициировать начало переноса
    document.body.appendChild player
    player.style.zIndex = 9999
    player.style.position = 'absolute'
    return

  findDroppable = (event) ->
    # спрячем переносимый элемент
    dragObject.player.hidden = true
    # получить самый вложенный элемент под курсором мыши
    elem = document.elementFromPoint(event.clientX, event.clientY)
    # показать переносимый элемент обратно
    dragObject.player.hidden = false
    if elem == null
      # такое возможно, если курсор мыши "вылетел" за границу окна
      return null
    elem.closest '.droppable'

  document.onmousemove = onMouseMove
  document.onmouseup = onMouseUp
  document.onmousedown = onMouseDown

  @onDragEnd = (dragObject, dropElem) ->

  @onDragCancel = (dragObject) ->

  return
)

getCoords = (elem) ->
  box = elem.getBoundingClientRect()
  {
    top: box.top + pageYOffset
    left: box.left + pageXOffset
  }
