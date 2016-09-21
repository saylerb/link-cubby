function getLinks(target = false, sortParams = '') {
  let request = new Request(`/api/v1/links${sortParams}`, { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => {
      response.forEach(link => appendRow(link))
      if (target) { target.data('sort') === 'desc' ? target.data('sort', 'asc') : target.data('sort', 'desc') }
    })
    .catch(err => console.log(err))
}

function getSortedLinksByTitle() {
  $('#title-header').on('click', e => {
    e.preventDefault()
    $('.link-row').remove()

    let target = $(e.target)
    let sortParams = `?sort=${target.data('sort')}&by=title`

    getLinks(target, sortParams)
  })
}

function getSortedLinksByURL() {
  $('#url-header').on('click', e => {
    e.preventDefault()
    $('.link-row').remove()

    let target = $(e.target)
    let sortParams = `?sort=${target.data('sort')}&by=url`

    getLinks(target, sortParams)
  })
}
