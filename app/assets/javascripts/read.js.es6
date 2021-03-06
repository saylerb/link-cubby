function getLinks(target = false, sortParams = '') {
  let request = new Request(`/api/v1/links${sortParams}`, { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => {
      $('.link-row').remove()
      response.forEach(link => appendRow(link))
      handleChevrons(target)
     })
    .catch(err => console.log(err))
}

function getSortedLinksByTitle() {
  $('#title-header').on('click', e => {
    e.preventDefault()

    let target = $(e.target).parent()
    let sortParams = `?sort=${target.data('sort')}&by=title`

    if (target.data('sort') === 'desc' || target.data('sort') === 'asc') {
      getLinks(target, sortParams)
    }
  })
}

function getSortedLinksByURL() {
  $('#url-header').on('click', e => {
    e.preventDefault()

    let target = $(e.target).parent()
    let sortParams = `?sort=${target.data('sort')}&by=url`

    if (target.data('sort') === 'desc' || target.data('sort') === 'asc') {
      getLinks(target, sortParams)
    }
  })
}

function handleChevrons(target) {
  if (target) {
    target.data('sort') === 'desc' ? target.data('sort', 'asc') : target.data('sort', 'desc')
    if (target.data('sort') === 'desc') {
      target.children().next().attr('class', 'glyphicon glyphicon-chevron-down')
    } else {
      target.children().next().attr('class', 'glyphicon glyphicon-chevron-up')
    }
  }
}
